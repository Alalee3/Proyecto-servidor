<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;

class FirmaService
{
    /**
     * Transforma una imagen de firma aplicando un pipeline profesional de precisión híbrida:
     * 1. Carga y super-muestreo (Upscaling) para maximizar la densidad del trazo.
     * 2. Umbralización Adaptativa Local nativa para una extracción fiel del grosor original.
     * 3. Segmentación por Componentes Conectados (CCL) iterativo en memoria de PHP.
     * 4. Recorte milimétrico al ras basado en coordenadas ópticas reales mapeadas.
     * 5. Reset estricto de lienzo virtual (Aplanamiento de página).
     * 6. Padding proporcional simétrico (95% utilización) y encuadre cuadrado centrado.
     * 7. Reducción óptima a PNG ligero (Nivel 9) y fondo transparente.
     *
     * @param  UploadedFile|string  $imagen  Archivo subido o ruta/blob binario
     * @return string  Datos binarios del PNG resultante
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
            // PASO 2: EXTRACCIÓN ADAPTATIVA (FIEL AL GROSOR ORIGINAL)
            // =================================================================
            $imagick->setImageType(\Imagick::IMGTYPE_GRAYSCALE);
            $quantum = \Imagick::getQuantum();

            // Extrae los bordes y el grosor real de la pluma de forma nativa
            $imagick->adaptiveThresholdImage(45, 45, -0.045 * $quantum);
            $imagick->thresholdImage(0.5 * $quantum);

            // =================================================================
            // PASO 3: ESCANEO ESTRUCTURAL POR MATRIZ SUB-MUESTREADA (CCL)
            // =================================================================
            // Clonamos la imagen limpia pura para realizar el análisis geométrico inteligente
            $thumb = clone $imagick;

            $thumbW = 300;
            $thumbH = (int) round($height * ($thumbW / $width));
            $thumb->resizeImage($thumbW, $thumbH, \Imagick::FILTER_BOX, 1);

            // Exportamos los píxeles de luminancia (0 = negro/tinta, 255 = blanco)
            $pixels = $thumb->exportImagePixels(0, 0, $thumbW, $thumbH, "I", \Imagick::PIXEL_CHAR);

            $thumb->clear();
            $thumb->destroy();

            $components = [];
            $totalPixels = $thumbW * $thumbH;

            // Análisis de Componentes Conectados (CCL) mediante DFS iterativo en memoria
            for ($i = 0; $i < $totalPixels; $i++) {
                if ($pixels[$i] < 127) {

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

                        for ($dx = -1; $dx <= 1; $dx++) {
                            for ($dy = -1; $dy <= 1; $dy++) {
                                if ($dx === 0 && $dy === 0)
                                    continue;

                                $nx = $cx + $dx;
                                $ny = $cy + $dy;

                                if ($nx >= 0 && $nx < $thumbW && $ny >= 0 && $ny < $thumbH) {
                                    $nIdx = ($ny * $thumbW) + $nx;
                                    if ($pixels[$nIdx] < 127) {
                                        $pixels[$nIdx] = 255;
                                        $stack[] = $nIdx;
                                    }
                                }
                            }
                        }
                    }

                    $components[] = [
                        'minX' => $cMinX,
                        'maxX' => $cMaxX,
                        'minY' => $cMinY,
                        'maxY' => $cMaxY,
                        'count' => $cCount
                    ];
                }
            }

            unset($pixels);

            if (empty($components)) {
                $finalCropX = 0;
                $finalCropY = 0;
                $finalCropW = $width;
                $finalCropH = $height;
            } else {
                $maxCount = max(array_column($components, 'count'));

                $validMinX = $thumbW;
                $validMaxX = 0;
                $validMinY = $thumbH;
                $validMaxY = 0;
                $hasValidStructure = false;

                foreach ($components as $comp) {
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

                $scale = $width / $thumbW;
                $cropLeft = (int) floor($validMinX * $scale);
                $cropTop = (int) floor($validMinY * $scale);
                $cropRight = (int) ceil(($validMaxX + 1) * $scale);
                $cropBottom = (int) ceil(($validMaxY + 1) * $scale);

                $cropW = $cropRight - $cropLeft;
                $cropH = $cropBottom - $cropTop;

                // Margen de seguridad estándar para no cortar las curvas suaves del trazo original
                $padding = 15;
                $finalCropX = max(0, $cropLeft - $padding);
                $finalCropY = max(0, $cropTop - $padding);
                $finalCropW = min($width - $finalCropX, $cropW + ($padding * 2));
                $finalCropH = min($height - $finalCropY, $cropH + ($padding * 2));
            }

            // Cortamos la imagen con el grosor intacto basándonos en los límites reales
            $imagick->cropImage($finalCropW, $finalCropH, $finalCropX, $finalCropY);

            // Aplanar estrictamente el lienzo para asimilar las nuevas dimensiones físicas
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

            $targetSize = (int) ($maxSide / 0.95);

            $pX = (int) (($targetSize - $cW) / 2);
            $pY = (int) (($targetSize - $cH) / 2);

            $paddedCanvas = new \Imagick();
            $paddedCanvas->newImage($targetSize, $targetSize, new \ImagickPixel('transparent'));
            $paddedCanvas->setImageFormat('png');

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