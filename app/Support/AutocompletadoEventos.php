<?php

namespace App\Support;

use App\Models\Evento;
use Carbon\Carbon;

class AutocompletadoEventos
{
    /**
     * Devuelve el Lunes de la semana N académica, ignorando las semanas festivas.
     */
    public static function lunesDeSemanaN(string $inicioLapso, int $semanaN, array $eventosRegistrados = [], bool $incluirVacaciones = false): ?Carbon
    {
        if ($semanaN < 1) {
            return CalendarioLapsoSemanas::lunesDeSemana($inicioLapso);
        }

        $festivas = CalendarioLapsoSemanas::lunesSemanasFestivas($eventosRegistrados, $incluirVacaciones);
        $lunes = CalendarioLapsoSemanas::lunesDeSemana($inicioLapso);
        $semanasContadas = 0;
        $maxIteraciones = $semanaN + count($festivas) + 104;

        for ($i = 0; $i < $maxIteraciones; $i++) {
            $lunesStr = $lunes->format('Y-m-d');

            if (!isset($festivas[$lunesStr])) {
                $semanasContadas++;
                if ($semanasContadas === $semanaN) {
                    return $lunes->copy();
                }
            }
            $lunes->addWeek();
        }

        return null;
    }

    /**
     * Encuentra las fechas de inicio y fin para un evento evitando días no laborables.
     */
    public static function calcularFechasEvento(Carbon $lunesInicio, int $diasRequeridos, array $eventosRegistrados, bool $incluyeFinesSemana = false): ?array
    {
        if ($diasRequeridos <= 0) return null;

        $fechaActual = $lunesInicio->copy()->startOfDay();
        $viernesSemana = $lunesInicio->copy()->addDays(4)->endOfDay();
        $domingoSemana = $lunesInicio->copy()->addDays(6)->endOfDay();
        $finSemanaObjetivo = $incluyeFinesSemana ? $domingoSemana : $viernesSemana;

        $diasAsignados = [];
        $diasBuscados = 0;
        
        $feriados = [];
        foreach ($eventosRegistrados as $ev) {
            $isLaborable = (bool) ($ev['is_laborable_evento'] ?? true);
            $esp = (string) ($ev['especial_evento'] ?? '');
            
            if (!$isLaborable || $esp === '1') {
                if (!isset($ev['inicio'])) continue;
                $feriados[] = [
                    'inicio' => Carbon::parse($ev['inicio'])->startOfDay(),
                    'fin' => Carbon::parse($ev['fin'] ?? $ev['inicio'])->endOfDay()
                ];
            }
        }

        $isFeriado = function(Carbon $fecha) use ($feriados) {
            foreach ($feriados as $f) {
                if ($fecha->between($f['inicio'], $f['fin'])) {
                    return true;
                }
            }
            return false;
        };

        while ($diasBuscados < $diasRequeridos) {
            // Regla de recorte: Si pasa de la semana objetivo y requiere > 2 días, se recorta.
            if ($fechaActual->gt($finSemanaObjetivo)) {
                if ($diasRequeridos > 2 && count($diasAsignados) > 0) {
                    break;
                }
            }

            // Salto de seguridad (max 60 dias)
            if ($fechaActual->diffInDays($lunesInicio) > 60) {
                break;
            }

            if (!$incluyeFinesSemana && $fechaActual->isWeekend()) {
                $fechaActual->addDay();
                continue;
            }

            if ($isFeriado($fechaActual)) {
                $fechaActual->addDay();
                continue;
            }

            $diasAsignados[] = $fechaActual->copy();
            $diasBuscados++;
            $fechaActual->addDay();
        }

        if (empty($diasAsignados)) return null;

        return [
            'inicio' => $diasAsignados[0]->format('Y-m-d'),
            'fin' => end($diasAsignados)->format('Y-m-d')
        ];
    }

    /**
     * Autocompleta los eventos en base a los lapsos registrados.
     * Reemplaza eventos no superponibles si hay colisión.
     * @return int Número de eventos agregados.
     */
    public static function autocompletarEventosDeLapso(array &$eventosRegistrados, array $bibliotecaEventos, array $lapsosAsignados, bool $incluirVacaciones = false): int
    {
        $eventosAgregados = 0;

        foreach ($lapsosAsignados as $lapso) {
            $inicioLapso = $lapso['inicio'];
            // Determinar tipo de lapso. '2' es lapso regular. '7' introductorio, etc.
            // En nuestra lógica, los lapsos regulares (1 o 2) vienen en orden para '2'.
            // Mapearemos los numero_lapso usando $lapso['numeroLapso'] si está disponible, 
            // sino asumimos un contador simple.
            $numeroLapso = $lapso['numero_lapso'] ?? 1;

            foreach ($bibliotecaEventos as $eventoObj) {
                $evento = (array) $eventoObj;
                // Verificar si tiene semanas y días fijos
                if (!empty($evento['is_semana_evento']) && !empty($evento['is_cantidad_dias_evento'])) {
                    $semanasConfig = is_array($evento['semana_evento']) 
                        ? $evento['semana_evento'] 
                        : (json_decode($evento['semana_evento'], true) ?? []);
                    
                    if (!$semanasConfig) continue;

                    foreach ($semanasConfig as $sConfig) {
                        $lapsoConf = is_array($sConfig) ? ($sConfig['lapso'] ?? 1) : 1;
                        $semanaConf = is_array($sConfig) ? ($sConfig['semana'] ?? 1) : (int) $sConfig;

                        if ((int)$lapsoConf === (int)$numeroLapso) {
                            $lunesN = self::lunesDeSemanaN($inicioLapso, $semanaConf, $eventosRegistrados, $incluirVacaciones);
                            if (!$lunesN) continue;

                            $diasRequeridos = (int) $evento['cantidad_dias_evento'];
                            $incluyeFinDeSemana = (bool) ($evento['is_fin_semana_evento'] ?? false);

                            $fechas = self::calcularFechasEvento($lunesN, $diasRequeridos, $eventosRegistrados, $incluyeFinDeSemana);

                            if ($fechas) {
                                // Si este evento NO es superponible, debemos quitar otros no superponibles que choquen
                                $esSuperponible = (bool) ($evento['is_superponible_evento'] ?? true);
                                if (!$esSuperponible) {
                                    $inicioNueva = Carbon::parse($fechas['inicio'])->startOfDay();
                                    $finNueva = Carbon::parse($fechas['fin'])->endOfDay();

                                    foreach ($eventosRegistrados as $idx => $evReg) {
                                        $esSupReg = (bool) ($evReg['is_superponible_evento'] ?? true);
                                        // Ignoramos feriados (suponiendo is_laborable=false o especial=1)
                                        $esFeriado = !($evReg['is_laborable_evento'] ?? true) || ($evReg['especial_evento'] ?? '') === '1';
                                        
                                        if (!$esSupReg && !$esFeriado) {
                                            $iReg = Carbon::parse($evReg['inicio'])->startOfDay();
                                            $fReg = Carbon::parse($evReg['fin'] ?? $evReg['inicio'])->endOfDay();

                                            // Si hay choque
                                            if ($inicioNueva->lte($fReg) && $finNueva->gte($iReg)) {
                                                // Eliminar el evento chocado
                                                unset($eventosRegistrados[$idx]);
                                            }
                                        }
                                    }
                                    $eventosRegistrados = array_values($eventosRegistrados); // reindex
                                }

                                // Verificamos si ya no estaba insertado exactamente igual (por seguridad)
                                $yaExiste = collect($eventosRegistrados)->contains(function($ev) use ($evento, $fechas) {
                                    return ($ev['id_evento'] ?? null) == $evento['id_evento'] && 
                                           ($ev['inicio'] ?? null) == $fechas['inicio'];
                                });

                                if (!$yaExiste) {
                                    $eventosRegistrados[] = [
                                        'id' => (int) $evento['id_evento'],
                                        'id_evento' => (int) $evento['id_evento'],
                                        'inicio' => $fechas['inicio'],
                                        'fin' => $fechas['fin'],
                                        'nombre' => $evento['nombre_evento'] ?? 'Evento Autocompletado',
                                        'nombre_evento' => $evento['nombre_evento'] ?? 'Evento Autocompletado',
                                        'tipo' => $evento['tipo_evento'] ?? '1',
                                        'color' => $evento['codigo_color_evento'] ?? '#000000',
                                        'codigo_color_evento' => $evento['codigo_color_evento'] ?? '#000000',
                                        'is_cantidad_dias_evento' => (bool) ($evento['is_cantidad_dias_evento'] ?? false),
                                        'cantidad_dias_evento' => $evento['cantidad_dias_evento'] ?? null,
                                        'especial_evento' => $evento['especial_evento'] ?? null,
                                        'is_laborable_evento' => (bool) ($evento['is_laborable_evento'] ?? true),
                                        'is_superponible_evento' => (bool) ($evento['is_superponible_evento'] ?? true),
                                        'is_repetible_evento' => (bool) ($evento['is_repetible_evento'] ?? false),
                                        'cantidad_repetible_evento' => $evento['cantidad_repetible_evento'] ?? null,
                                        'is_independiente_evento' => (bool) ($evento['is_independiente_evento'] ?? false),
                                        'is_dia_evento' => (bool) ($evento['is_dia_evento'] ?? false),
                                        'ignorar_fines_semana' => !(bool)($evento['is_fin_semana_evento'] ?? false),
                                        'ignorar_feriados_locales' => false,
                                    ];
                                    $eventosAgregados++;
                                }
                            }
                        }
                    }
                }
            }
        }

        return $eventosAgregados;
    }
}
