<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;

class FirmaService
{
    /**
     * Transforma una imagen de firma a PNG con fondo transparente y enfoque dinámico robusto.
     * Blindado contra manchas complejas y ruido en los extremos de los ejes X/Y.
     */
    public static function maikol_callate($imagen): string
    {
        // --- 1. Resolver fuente de imagen ---
        if ($imagen instanceof UploadedFile) {
            $rutaTemp = $imagen->getRealPath();
            $deleteTmp = false;
        } elseif (is_string($imagen) && file_exists($imagen)) {
            $rutaTemp = $imagen;
            $deleteTmp = false;
        } elseif (is_string($imagen)) {
            $rutaTemp = tempnam(sys_get_temp_dir(), 'firma_');
            file_put_contents($rutaTemp, $imagen);
            $deleteTmp = true;
        } else {
            throw new \InvalidArgumentException('La imagen debe ser un UploadedFile, ruta válida o blob binario.');
        }

        try {
            // --- 2. Leer metadatos ---
            $info = getimagesize($rutaTemp);
            if (!$info) {
                throw new \RuntimeException('No se pudo leer la imagen.');
            }

            $mime = $info['mime'];
            $width = $info[0];
            $height = $info[1];

            // --- 3. Crear recurso GD ---
            $src = match ($mime) {
                'image/jpeg', 'image/jpg' => @imagecreatefromjpeg($rutaTemp),
                'image/png' => @imagecreatefrompng($rutaTemp),
                'image/gif' => @imagecreatefromgif($rutaTemp),
                'image/webp' => @imagecreatefromwebp($rutaTemp),
                'image/bmp' => @imagecreatefrombmp($rutaTemp),
                default => throw new \RuntimeException("Formato no soportado: {$mime}"),
            };

            if (!$src) {
                throw new \RuntimeException('GD no pudo abrir la imagen.');
            }

            imagealphablending($src, false);
            imagesavealpha($src, true);

            // --- 4. Redimensionar a máximo 1200px ---
            $maxDim = 1200;
            if ($width > $maxDim || $height > $maxDim) {
                $ratio = min($maxDim / $width, $maxDim / $height);
                $newWidth = (int) round($width * $ratio);
                $newHeight = (int) round($height * $ratio);

                $resized = imagecreatetruecolor($newWidth, $newHeight);
                imagealphablending($resized, false);
                imagesavealpha($resized, true);
                imagecopyresampled($resized, $src, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
                imagedestroy($src);
                $src = $resized;
                $width = $newWidth;
                $height = $newHeight;
            }

            // --- 5a. Pre-procesado ---
            imagefilter($src, IMG_FILTER_CONTRAST, 10);
            imagefilter($src, IMG_FILTER_BRIGHTNESS, 5);

            // --- 5b. Construcción del Mapa de Iluminación Local ---
            $factor = 20;
            $smallWidth = max(1, (int) ($width / $factor));
            $smallHeight = max(1, (int) ($height / $factor));

            $bgSmall = imagecreatetruecolor($smallWidth, $smallHeight);
            imagecopyresampled($bgSmall, $src, 0, 0, 0, 0, $smallWidth, $smallHeight, $width, $height);

            $bgMap = imagecreatetruecolor($width, $height);
            imagecopyresampled($bgMap, $bgSmall, 0, 0, 0, 0, $width, $height, $smallWidth, $smallHeight);
            imagedestroy($bgSmall);

            imagefilter($bgMap, IMG_FILTER_GAUSSIAN_BLUR);
            imagefilter($bgMap, IMG_FILTER_GAUSSIAN_BLUR);

            // --- 6. Binarización Pura Calibrada ---
            $INK_THRESHOLD = 14;

            $dest = imagecreatetruecolor($width, $height);
            imagealphablending($dest, false);
            imagesavealpha($dest, true);

            $fullyTransparent = imagecolorallocatealpha($dest, 0, 0, 0, 127);
            imagefill($dest, 0, 0, $fullyTransparent);

            $inkBlack = imagecolorallocatealpha($dest, 0, 0, 0, 0);

            for ($x = 0; $x < $width; $x++) {
                for ($y = 0; $y < $height; $y++) {
                    $rgb1 = imagecolorat($src, $x, $y);

                    $alphaSrc = ($rgb1 >> 24) & 0x7F;
                    if ($alphaSrc > 115) {
                        continue;
                    }

                    $l1 = 0.299 * (($rgb1 >> 16) & 0xFF)
                        + 0.587 * (($rgb1 >> 8) & 0xFF)
                        + 0.114 * ($rgb1 & 0xFF);

                    $rgb2 = imagecolorat($bgMap, $x, $y);
                    $l2 = 0.299 * (($rgb2 >> 16) & 0xFF)
                        + 0.587 * (($rgb2 >> 8) & 0xFF)
                        + 0.114 * ($rgb2 & 0xFF);

                    if (($l2 - $l1) > $INK_THRESHOLD && $l1 < 235) {
                        imagesetpixel($dest, $x, $y, $inkBlack);
                    }
                }
            }

            imagedestroy($src);
            imagedestroy($bgMap);

            // --- 7. trimImage en GD Blindado de Alta Densidad ---
            $left = self::findEdge($dest, $width, $height, 'left');
            $right = self::findEdge($dest, $width, $height, 'right');
            $top = self::findEdge($dest, $width, $height, 'top');
            $bottom = self::findEdge($dest, $width, $height, 'bottom');

            if ($left !== null && $right !== null && $top !== null && $bottom !== null) {
                $cropW = $right - $left + 1;
                $cropH = $bottom - $top + 1;

                $cropped = imagecreatetruecolor($cropW, $cropH);
                imagealphablending($cropped, false);
                imagesavealpha($cropped, true);
                $t2 = imagecolorallocatealpha($cropped, 0, 0, 0, 127);
                imagefill($cropped, 0, 0, $t2);

                imagecopy($cropped, $dest, 0, 0, $left, $top, $cropW, $cropH);
                imagedestroy($dest);
                $dest = $cropped;

                // --- 8. Padding Proporcional Perfecto en Ambos Ejes (95% Canvas Utilization) ---
                $cW = imagesx($dest);
                $cH = imagesy($dest);

                $maxSide = max($cW, $cH);
                $targetSize = (int) ($maxSide / 0.95);

                $pX = ($targetSize - $cW) / 2;
                $pY = ($targetSize - $cH) / 2;

                $padded = imagecreatetruecolor($targetSize, $targetSize);
                imagealphablending($padded, false);
                imagesavealpha($padded, true);
                $t3 = imagecolorallocatealpha($padded, 0, 0, 0, 127);
                imagefill($padded, 0, 0, $t3);

                imagecopy($padded, $dest, (int) $pX, (int) $pY, 0, 0, $cW, $cH);
                imagedestroy($dest);
                $dest = $padded;
            }

            // --- 9. Exportar PNG ---
            ob_start();
            imagepng($dest, null, 9);
            $pngData = ob_get_clean();
            imagedestroy($dest);

            if (strlen($pngData) > 1.5 * 1024 * 1024) {
                throw new \RuntimeException('La imagen es demasiado pesada para guardar.');
            }

            return $pngData;

        } finally {
            if (isset($deleteTmp) && $deleteTmp && isset($rutaTemp)) {
                @unlink($rutaTemp);
            }
        }
    }

    /**
     * Escanea los bordes validando mediante una matriz de densidad de área extendida.
     */
    private static function findEdge(\GdImage $img, int $width, int $height, string $edge): ?int
    {
        switch ($edge) {
            case 'left':
                for ($x = 0; $x < $width; $x++) {
                    for ($y = 0; $y < $height; $y++) {
                        if (self::isRealStructure($img, $x, $y, $width, $height))
                            return $x;
                    }
                }
                break;
            case 'right':
                for ($x = $width - 1; $x >= 0; $x--) {
                    for ($y = 0; $y < $height; $y++) {
                        if (self::isRealStructure($img, $x, $y, $width, $height))
                            return $x;
                    }
                }
                break;
            case 'top':
                for ($y = 0; $y < $height; $y++) {
                    for ($x = 0; $x < $width; $x++) {
                        if (self::isRealStructure($img, $x, $y, $width, $height))
                            return $y;
                    }
                }
                break;
            case 'bottom':
                for ($y = $height - 1; $y >= 0; $y--) {
                    for ($x = 0; $x < $width; $x++) {
                        if (self::isRealStructure($img, $x, $y, $width, $height))
                            return $y;
                    }
                }
                break;
        }
        return null;
    }

    /**
     * Filtro de Densidad Macroscópico 5x5.
     * Rompe y descarta agrupaciones de ruido de fondo, forzando el centrado real de la firma.
     */
    private static function isRealStructure(\GdImage $img, int $x, int $y, int $width, int $height): bool
    {
        if (!self::isInkPixel($img, $x, $y)) {
            return false;
        }

        $densityCount = 0;

        // Escaneo perimetral en radio de 2 píxeles (bloque completo de 5x5)
        for ($dx = -2; $dx <= 2; $dx++) {
            for ($dy = -2; $dy <= 2; $dy++) {
                $nx = $x + $dx;
                $ny = $y + $dy;

                if ($nx >= 0 && $nx < $width && $ny >= 0 && $ny < $height) {
                    if (self::isInkPixel($img, $nx, $ny)) {
                        $densityCount++;
                    }
                }
            }
        }

        // Un clúster pequeño de ruido (manchas aisladas) dará un conteo máximo de 4 píxeles.
        // Cualquier trazo real de firma cruzando este cuadrante sumará 6 o más píxeles activos.
        return $densityCount >= 6;
    }

    private static function isInkPixel(\GdImage $img, int $x, int $y): bool
    {
        $color = imagecolorat($img, $x, $y);
        $alpha = ($color >> 24) & 0x7F;
        return $alpha < 127;
    }

    public static function optimizarParaFirma(string $pngData): string
    {
        return $pngData;
    }
}