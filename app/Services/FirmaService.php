<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;

class FirmaService
{
    /**
     * Transforma una imagen subida a PNG sin fondo (fondo transparente).
     * 
     * Esta función recibe cualquier imagen (JPEG, PNG, GIF, WebP) y:
     * 1. Redimensiona la imagen a un máximo de 400px para rendimiento óptimo
     * 2. Detecta el color de fondo predominante (basado en las esquinas/bordes)
     * 3. Convierte ese color de fondo a transparencia
     * 4. Suaviza los bordes para un resultado más limpio
     * 5. Devuelve los datos binarios de la imagen PNG resultante
     *
     * @param UploadedFile|string $imagen Archivo subido o ruta a la imagen
     * @param int $threshold Umbral de sensibilidad (0-255). Más alto = más agresivo al quitar fondo.
     *                        Default: 180 (recomendado para firmas escaneadas con fondo blanco)
     * @return string Datos binarios de la imagen PNG resultante
     * @throws \Exception
     */
    public static function maikol_callate($imagen, int $threshold = 180): string
    {
        // Cargar la imagen según el tipo de entrada
        if ($imagen instanceof UploadedFile) {
            $rutaTemp = $imagen->getRealPath();
        } elseif (is_string($imagen) && file_exists($imagen)) {
            $rutaTemp = $imagen;
        } elseif (is_string($imagen)) {
            $rutaTemp = tempnam(sys_get_temp_dir(), 'firma_');
            file_put_contents($rutaTemp, $imagen);
        } else {
            throw new \InvalidArgumentException('La imagen debe ser un UploadedFile, una ruta válida o contenido binario.');
        }

        try {
            // Obtener información de la imagen
            $info = getimagesize($rutaTemp);
            if (!$info) {
                throw new \RuntimeException('No se pudo leer la imagen.');
            }

            $mime = $info['mime'];
            $width = $info[0];
            $height = $info[1];

            // Crear recurso GD según el tipo MIME
            $src = match ($mime) {
                'image/jpeg', 'image/jpg' => @imagecreatefromjpeg($rutaTemp),
                'image/png' => @imagecreatefrompng($rutaTemp),
                'image/gif' => @imagecreatefromgif($rutaTemp),
                'image/webp' => @imagecreatefromwebp($rutaTemp),
                'image/bmp' => @imagecreatefrombmp($rutaTemp),
                default => throw new \RuntimeException("Formato de imagen no soportado: {$mime}"),
            };

            if (!$src) {
                throw new \RuntimeException('No se pudo crear el recurso de imagen GD.');
            }

            // Redimensionar a un máximo de 400px para mantener rendimiento óptimo
            $maxDim = 400;
            if ($width > $maxDim || $height > $maxDim) {
                $ratio = min($maxDim / $width, $maxDim / $height);
                $newWidth = (int)round($width * $ratio);
                $newHeight = (int)round($height * $ratio);
                $resized = imagecreatetruecolor($newWidth, $newHeight);
                imagealphablending($resized, false);
                imagesavealpha($resized, true);
                imagecopyresampled($resized, $src, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
                imagedestroy($src);
                $src = $resized;
                $width = $newWidth;
                $height = $newHeight;
            }

            // Detectar el color de fondo predominante muestreando las esquinas
            $bgColor = self::detectarColorFondo($src, $width, $height);

            // Crear imagen destino con canal alpha
            $dest = imagecreatetruecolor($width, $height);
            imagealphablending($dest, false);
            imagesavealpha($dest, true);

            // Llenar con transparencia total
            $transparente = imagecolorallocatealpha($dest, 0, 0, 0, 127);
            imagefill($dest, 0, 0, $transparente);

            // Procesar pixel por pixel
            $bgR = ($bgColor >> 16) & 0xFF;
            $bgG = ($bgColor >> 8) & 0xFF;
            $bgB = $bgColor & 0xFF;

            $thresholdNormalized = ($threshold / 255);

            for ($x = 0; $x < $width; $x++) {
                for ($y = 0; $y < $height; $y++) {
                    $rgb = imagecolorat($src, $x, $y);
                    $r = ($rgb >> 16) & 0xFF;
                    $g = ($rgb >> 8) & 0xFF;
                    $b = $rgb & 0xFF;

                    // Calcular distancia del color al color de fondo (sin sqrt por rendimiento)
                    $distSq = pow($r - $bgR, 2) + pow($g - $bgG, 2) + pow($b - $bgB, 2);
                    $maxDistSq = 3 * pow(255, 2); // ~195075

                    // Normalizar a 0-127 para alpha (127 = completamente transparente)
                    $alpha = (int)(127 * (1 - min(1, $distSq / ($maxDistSq * $thresholdNormalized * $thresholdNormalized))));
                    $alpha = max(0, min(127, $alpha));

                    $color = imagecolorallocatealpha($dest, $r, $g, $b, $alpha);
                    imagesetpixel($dest, $x, $y, $color);
                }
            }

            imagedestroy($src);

            // Capturar la imagen PNG en un buffer
            ob_start();
            imagepng($dest);
            $pngData = ob_get_clean();
            imagedestroy($dest);

            return $pngData;

        } finally {
            if (isset($rutaTemp) && !($imagen instanceof UploadedFile) && !(is_string($imagen) && file_exists($imagen))) {
                @unlink($rutaTemp);
            }
        }
    }

    /**
     * Detecta el color de fondo predominante muestreando las esquinas y bordes.
     *
     * @param \GdImage $src
     * @param int $width
     * @param int $height
     * @return int Color RGB empaquetado
     */
    private static function detectarColorFondo($src, int $width, int $height): int
    {
        $colores = [];

        // Muestrear esquinas (5x5 pixels en cada esquina)
        $muestras = [
            [0, 0], [0, 1], [1, 0], [1, 1], [2, 2],
            [$width - 1, 0], [$width - 2, 0], [$width - 1, 1],
            [0, $height - 1], [0, $height - 2], [1, $height - 1],
            [$width - 1, $height - 1], [$width - 2, $height - 1], [$width - 1, $height - 2],
        ];

        // También muestrear bordes cada 10%
        $stepX = max(1, intval($width / 10));
        $stepY = max(1, intval($height / 10));
        for ($i = 0; $i < $width; $i += $stepX) {
            $muestras[] = [$i, 0];
            $muestras[] = [$i, $height - 1];
        }
        for ($i = 0; $i < $height; $i += $stepY) {
            $muestras[] = [0, $i];
            $muestras[] = [$width - 1, $i];
        }

        $agrupados = [];
        foreach ($muestras as [$x, $y]) {
            if ($x >= 0 && $x < $width && $y >= 0 && $y < $height) {
                $rgb = imagecolorat($src, $x, $y);
                // Cuantizar para agrupar colores similares
                $r = (($rgb >> 16) & 0xFF) & 0xF0;
                $g = (($rgb >> 8) & 0xFF) & 0xF0;
                $b = ($rgb & 0xFF) & 0xF0;
                $clave = ($r << 16) | ($g << 8) | $b;
                $agrupados[$clave] = ($agrupados[$clave] ?? 0) + 1;
            }
        }

        // El color más frecuente es el fondo
        arsort($agrupados);
        $colorFondoCuantizado = key($agrupados);

        // Devolver el color original (no cuantizado) del primer match
        $colorFondoCuantizado = (int)$colorFondoCuantizado;
        foreach ($muestras as [$x, $y]) {
            $rgb = imagecolorat($src, $x, $y);
            $r = (($rgb >> 16) & 0xFF) & 0xF0;
            $g = (($rgb >> 8) & 0xFF) & 0xF0;
            $b = ($rgb & 0xFF) & 0xF0;
            if ((($r << 16) | ($g << 8) | $b) === $colorFondoCuantizado) {
                return $rgb;
            }
        }

        return 0xFFFFFF; // Blanco por defecto
    }

    /**
     * Convierte una imagen a PNG optimizado para firma (escala de grises, alto contraste).
     *
     * @param string $pngData Datos binarios de la imagen PNG
     * @return string PNG optimizado
     */
    public static function optimizarParaFirma(string $pngData): string
    {
        $src = imagecreatefromstring($pngData);
        if (!$src) {
            throw new \RuntimeException('No se pudo procesar la imagen PNG.');
        }

        $width = imagesx($src);
        $height = imagesy($src);

        $dest = imagecreatetruecolor($width, $height);
        imagealphablending($dest, false);
        imagesavealpha($dest, true);

        $transparente = imagecolorallocatealpha($dest, 0, 0, 0, 127);
        imagefill($dest, 0, 0, $transparente);

        for ($x = 0; $x < $width; $x++) {
            for ($y = 0; $y < $height; $y++) {
                $rgb = imagecolorat($src, $x, $y);
                $alpha = ($rgb >> 24) & 0x7F;

                if ($alpha < 127) {
                    $r = ($rgb >> 16) & 0xFF;
                    $g = ($rgb >> 8) & 0xFF;
                    $b = $rgb & 0xFF;

                    // Convertir a gris ponderado (percepción humana)
                    $gray = (int)(0.299 * $r + 0.587 * $g + 0.114 * $b);

                    // Aumentar contraste: si es oscuro, poner más oscuro; si es claro, más transparente
                    if ($gray < 128) {
                        $gray = max(0, $gray - 30);
                    }

                    $color = imagecolorallocatealpha($dest, $gray, $gray, $gray, $alpha);
                    imagesetpixel($dest, $x, $y, $color);
                }
            }
        }

        imagedestroy($src);

        ob_start();
        imagepng($dest, null, 9); // Máxima compresión
        $optimized = ob_get_clean();
        imagedestroy($dest);

        return $optimized;
    }
}
