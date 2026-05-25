<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;

class FirmaService
{
    /**
     * Transforma una imagen de firma aplicando un pipeline híbrido de visión artificial:
     * 1. Carga y super-muestreo (Upscaling) para maximizar la densidad del trazo.
     * 2. Umbralización Adaptativa Local nativa para limpieza profunda de fondos y sombras.
     * 3. Segmentación por Componentes Conectados (CCL) iterativo en memoria RAM de PHP.
     * 4. Discriminación geométrica de masa (Desintegra islas de ruido y pelusas flotantes).
     * 5. Recorte al ras sobre la imagen nítida original con geometría molecular real.
     * 6. Fondo transparente con encuadre cuadrado equilibrado al centro (95% de uso).
     *
     * @param  UploadedFile|string  $imagen  Archivo subido o ruta/blob binario
     * @return string  Datos binarios del PNG resultante (Fondo transparente, ultra-ligero)
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
            // --- 2. Instanciar Imagick y leer la imagen ---
            if (!class_exists('\Imagick')) {
                throw new \RuntimeException('La extensión php-imagick no está habilitada en tu servidor PHP.');
            }

            $imagick = new \Imagick();
            $imagick->readImage($rutaTemp);

            // =================================================================
            // PASO 1: SUPER-MUESTREO (RESOLUCIÓN ÓPTIMA DE TRABAJO)
            // =================================================================
            $srcWidth = $imagick->getImageWidth();
            $srcHeight = $imagick->getImageHeight();
            $superDim = 1200; // Resolución equilibrada para garantizar nitidez y escaneo veloz

            if ($srcWidth < $superDim && $srcHeight < $superDim) {
                $ratio = $superDim / max($srcWidth, $srcHeight);
                $width = (int) round($srcWidth * $ratio);
                $height = (int) round($srcHeight * $ratio);
                $imagick->resizeImage($width, $height, \Imagick::FILTER_CUBIC, 1);
            } else {
                $width = $srcWidth;
                $height = $srcHeight;
            }

            // =================================================================
            // PASO 2: EXTRACCIÓN ADAPTATIVA (BINARIZACIÓN PURA)
            // =================================================================
            $imagick->setImageType(\Imagick::IMGTYPE_GRAYSCALE);
            $quantum = \Imagick::getQuantum();
            $imagick->adaptiveThresholdImage(45, 45, -0.045 * $quantum);
            $imagick->thresholdImage(0.5 * $quantum);

            // =================================================================
            // PASO 3: SEGMENTACIÓN DE COMPONENTES CONECTADOS (INTELIGENCIA CCL)
            // =================================================================
            // Creamos una miniatura de control para mapear las estructuras moleculares de tinta
            $thumb = clone $imagick;
            $thumbW = 300; // Escala perfecta: las motas se minimizan y los trazos mantienen continuidad
            $thumbH = (int) round($height * ($thumbW / $width));
            $thumb->resizeImage($thumbW, $thumbH, \Imagick::FILTER_BOX, 1);

            // Exportamos los píxeles de luminancia (0 = negro/tinta, 255 = blanco/vacío)
            $pixels = $thumb->exportImagePixels(0, 0, $thumbW, $thumbH, "I", \Imagick::PIXEL_CHAR);

            $thumb->clear();
            $thumb->destroy();

            $components = [];
            $totalPixels = $thumbW * $thumbH;

            // Algoritmo de Etiquetado de Componentes Conectados (CCL) mediante DFS iterativo
            for ($i = 0; $i < $totalPixels; $i++) {
                if ($pixels[$i] < 127) { // Píxel negro (tinta detectada)

                    // Inicializamos pila de control e invertimos a blanco para marcarlo como visitado
                    $stack = [$i];
                    $pixels[$i] = 255;

                    $cMinX = $i % $thumbW;
                    $cMaxX = $cMinX;
                    $cMinY = (int) ($i / $thumbW);
                    $cMaxY = $cMinY;
                    $cCount = 0;

                    while (!empty($stack)) {
                        $idx = array_pop($stack);
                        $cCount++;

                        $cx = $idx % $thumbW;
                        $cy = (int) ($idx / $thumbW);

                        if ($cx < $cMinX)
                            $cMinX = $cx;
                        if ($cx > $cMaxX)
                            $cMaxX = $cx;
                        if ($cy < $cMinY)
                            $cMinY = $cy;
                        if ($cy > $cMaxY)
                            $cMaxY = $cy;

                        // Análisis de vecindad de 8 conectividades
                        for ($dx = -1; $dx <= 1; $dx++) {
                            for ($dy = -1; $dy <= 1; $dy++) {
                                if ($dx === 0 && $dy === 0)
                                    continue;

                                $nx = $cx + $dx;
                                $ny = $cy + $dy;

                                if ($nx >= 0 && $nx < $thumbW && $ny >= 0 && $ny < $thumbH) {
                                    $nIdx = ($ny * $thumbW) + $nx;
                                    if ($pixels[$nIdx] < 127) {
                                        $pixels[$nIdx] = 255; // Marcamos visitado antes de apilar para optimizar RAM
                                        $stack[] = $nIdx;
                                    }
                                }
                            }
                        }
                    }

                    // Guardamos la isla encontrada con su masa física de píxeles y límites
                    $components[] = [
                        'minX' => $cMinX,
                        'maxX' => $cMaxX,
                        'minY' => $cMinY,
                        'maxY' => $cMaxY,
                        'count' => $cCount
                    ];
                }
            }

            unset($pixels); // Liberamos el mapa de bits de la memoria RAM de inmediato

            if (empty($components)) {
                // Salvaguarda: si no se detecta tinta, mantenemos las dimensiones de trabajo
                $finalCropX = 0;
                $finalCropY = 0;
                $finalCropW = $width;
                $finalCropH = $height;
            } else {
                // Identificamos el componente de máxima masa (El núcleo principal de la firma)
                $maxCount = max(array_column($components, 'count'));

                $validMinX = $thumbW;
                $validMaxX = 0;
                $validMinY = $thumbH;
                $validMaxY = 0;
                $hasValidStructure = false;

                // FILTRADO GEOMÉTRICO: Evaluamos qué islas pertenecen a la firma y cuáles son ruido
                foreach ($components as $comp) {
                    // Criterio inteligente: se aceptan componentes con al menos el 2.5% de la masa del bloque principal
                    // (Esto rescata acentos, puntos de la 'i' o rúbricas segmentadas, eliminando motas de polvo aisladas)
                    if ($comp['count'] >= max(3, $maxCount * 0.025)) {
                        if ($comp['minX'] < $validMinX)
                            $validMinX = $comp['minX'];
                        if ($comp['maxX'] > $validMaxX)
                            $validMaxX = $comp['maxX'];
                        if ($comp['minY'] < $validMinY)
                            $validMinY = $comp['minY'];
                        if ($comp['maxY'] > $validMaxY)
                            $validMaxY = $comp['maxY'];
                        $hasValidStructure = true;
                    }
                }

                // Si todo el lienzo fue discriminado por el filtro, retrocedemos al componente más grande
                if (!$hasValidStructure) {
                    foreach ($components as $comp) {
                        if ($comp['count'] === $maxCount) {
                            $validMinX = $comp['minX'];
                            $validMaxX = $comp['maxX'];
                            $validMinY = $comp['minY'];
                            $validMaxY = $comp['maxY'];
                            break;
                        }
                    }
                }

                // Escalamos los límites de la miniatura de vuelta a la alta resolución original
                $scale = $width / $thumbW;
                $cropLeft = (int) floor($validMinX * $scale);
                $cropTop = (int) floor($validMinY * $scale);
                $cropRight = (int) ceil(($validMaxX + 1) * $scale);
                $cropBottom = (int) ceil(($validMaxY + 1) * $scale);

                $cropW = $cropRight - $cropLeft;
                $cropH = $cropBottom - $cropTop;

                // Margen de seguridad quirúrgico de 15px para resguardar bordes antialias suavizados
                $padding = 15;
                $finalCropX = max(0, $cropLeft - $padding);
                $finalCropY = max(0, $cropTop - $padding);
                $finalCropW = min($width - $finalCropX, $cropW + ($padding * 2));
                $finalCropH = min($height - $finalCropY, $cropH + ($padding * 2));
            }

            // Ejecutamos el recorte exacto libre de espacios vacíos artificiales
            $imagick->cropImage($finalCropW, $finalCropH, $finalCropX, $finalCropY);

            // Aplanar el lienzo físico para resetear coordenadas virtuales de página
            $imagick->setImagePage(0, 0, 0, 0);

            // =================================================================
            // PASO 4: EXTRAER FONDO TRANSPARENTE
            // =================================================================
            $targetWhite = new \ImagickPixel('white');
            $imagick->transparentPaintImage($targetWhite, 0, 0.05 * $quantum, false);

            // =================================================================
            // PASO 5: PADDING PROPORCIONAL Y ENCUADRE CUADRADO PERFECTO
            // =================================================================
            $cW = $imagick->getImageWidth();
            $cH = $imagick->getImageHeight();
            $maxSide = max($cW, $cH);

            // Configuración al 95% de utilización para un encuadre estético e idóneo
            $targetSize = (int) ($maxSide / 0.95);

            $pX = (int) (($targetSize - $cW) / 2);
            $pY = (int) (($targetSize - $cH) / 2);

            $paddedCanvas = new \Imagick();
            $paddedCanvas->newImage($targetSize, $targetSize, new \ImagickPixel('transparent'));
            $paddedCanvas->setImageFormat('png');

            // Posicionamos la firma recortada en el centro absoluto del lienzo cuadrado
            $paddedCanvas->compositeImage($imagick, \Imagick::COMPOSITE_COPY, $pX, $pY);

            $imagick->clear();
            $imagick->destroy();
            $imagick = $paddedCanvas;

            // =================================================================
            // PASO 6: REDUCCIÓN ÓPTIMA FINAL Y COMPRESIÓN PNG
            // =================================================================
            $finalDim = 800;
            if ($imagick->getImageWidth() > $finalDim) {
                $imagick->scaleImage($finalDim, 0);
            }

            $imagick->setImageFormat('png');
            $imagick->setCompressionQuality(9);
            $imagick->stripImage();

            $pngData = $imagick->getImageBlob();

            $imagick->clear();
            $imagick->destroy();

            return $pngData;

        } catch (\ImagickException $e) {
            throw new \RuntimeException('Error procesando la firma: ' . $e->getMessage());
        } finally {
            if (isset($deleteTmp) && $deleteTmp && isset($rutaTemp)) {
                @unlink($rutaTemp);
            }
        }
    }

    /**
     * Mantenemos el método por compatibilidad con tus controladores.
     */
    public static function optimizarParaFirma(string $pngData): string
    {
        return $pngData;
    }
}