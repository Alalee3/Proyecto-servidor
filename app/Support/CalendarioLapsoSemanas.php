<?php

namespace App\Support;

use App\Models\Evento;
use Carbon\Carbon;

/**
 * Cálculo de semanas de lapso alineado con la cuadrícula (semanas lun–dom).
 * Las semanas con eventos especiales 4 (Semana Santa) o 5 (Carnaval) no cuentan.
 */
class CalendarioLapsoSemanas
{
    /**
     * Lunes de la semana que contiene la fecha (misma lógica que la cuadrícula JS).
     */
    public static function lunesDeSemana(string $fecha): Carbon
    {
        return Carbon::parse($fecha)->startOfWeek(Carbon::MONDAY);
    }

    /**
     * Lunes (Y-m-d) de cada semana festiva según eventos ya asignados al calendario.
     * Una semana se considera festiva si los 5 días laborables (lunes a viernes)
     * están completamente cubiertos por eventos no laborables.
     *
     * @param  array<int, array<string, mixed>>  $eventosRegistrados
     * @return array<string, true>
     */
    public static function lunesSemanasFestivas(array $eventosRegistrados, bool $incluirVacaciones = false): array
    {
        $festivas = [];
        
        $minDate = null;
        $maxDate = null;
        $eventosNoLaborables = [];
        
        foreach ($eventosRegistrados as $ev) {
            // Asegurar que leemos el atributo (si no existe, asumimos laborable por seguridad)
            $isLaborable = (bool) ($ev['is_laborable_evento'] ?? true);
            $esp = (string) ($ev['especial_evento'] ?? '');
            
            // Excepción para Vacaciones Colectivas: solo son no-laborables si la bandera lo dicta
            if ($esp === '1' && !$incluirVacaciones) {
                continue;
            }
            
            // Si el evento es explícitamente no laborable (o es Vacaciones y $incluirVacaciones es true)
            if (!$isLaborable || ($esp === '1' && $incluirVacaciones)) {
                $inicio = $ev['inicio'] ?? null;
                $fin = $ev['fin'] ?? $inicio;
                if (!$inicio) continue;
                
                $dtInicio = Carbon::parse($inicio)->startOfDay();
                $dtFin = Carbon::parse($fin)->endOfDay();
                
                if (!$minDate || $dtInicio->lt($minDate)) $minDate = $dtInicio->copy();
                if (!$maxDate || $dtFin->gt($maxDate)) $maxDate = $dtFin->copy();
                
                $eventosNoLaborables[] = [
                    'inicio' => $dtInicio,
                    'fin' => $dtFin,
                ];
            }
        }
        
        if (empty($eventosNoLaborables)) {
            return [];
        }
        
        // Evaluar semana a semana dentro del rango de los eventos
        $lunesActual = self::lunesDeSemana($minDate->format('Y-m-d'));
        $lunesFinal = self::lunesDeSemana($maxDate->format('Y-m-d'));
        
        while ($lunesActual->lte($lunesFinal)) {
            $semanaCubierta = true;
            
            // Revisar cada día de la semana (0 = Lunes, 1 = Martes, ..., 4 = Viernes)
            for ($d = 0; $d < 5; $d++) {
                $diaEvaluar = $lunesActual->copy()->addDays($d)->startOfDay();
                $diaCubierto = false;
                
                foreach ($eventosNoLaborables as $evNL) {
                    if ($diaEvaluar->between($evNL['inicio'], $evNL['fin'])) {
                        $diaCubierto = true;
                        break;
                    }
                }
                
                // Si encontramos un día de lun-vie que NO está cubierto, la semana no es festiva
                if (!$diaCubierto) {
                    $semanaCubierta = false;
                    break;
                }
            }
            
            if ($semanaCubierta) {
                $festivas[$lunesActual->format('Y-m-d')] = true;
            }
            
            $lunesActual->addWeek();
        }

        return $festivas;
    }

    /**
     * Viernes de la semana N académica (omite semanas festivas 4/5).
     *
     * @param  array<int, array<string, mixed>>  $eventosRegistrados
     */
    public static function fechaFinLapso(string $inicio, int $semanas, array $eventosRegistrados = [], bool $incluirVacaciones = false): string
    {
        if ($semanas < 1) {
            return $inicio;
        }

        $festivas = self::lunesSemanasFestivas($eventosRegistrados, $incluirVacaciones);
        $lunes = self::lunesDeSemana($inicio);
        $semanasContadas = 0;
        $maxIteraciones = $semanas + count($festivas) + 104;

        for ($i = 0; $i < $maxIteraciones; $i++) {
            $lunesStr = $lunes->format('Y-m-d');

            if (!isset($festivas[$lunesStr])) {
                $semanasContadas++;
                if ($semanasContadas >= $semanas) {
                    return $lunes->copy()->addDays(4)->format('Y-m-d');
                }
            }

            $lunes->addWeek();
        }

        return self::lunesDeSemana($inicio)
            ->addDays(($semanas * 7) - 3)
            ->format('Y-m-d');
    }

    /**
     * Semanas académicas entre inicio y fin (omite semanas festivas 4/5).
     *
     * @param  array<int, array<string, mixed>>  $eventosRegistrados
     */
    public static function contarSemanas(string $inicio, string $fin, array $eventosRegistrados = [], bool $incluirVacaciones = false): int
    {
        $festivas = self::lunesSemanasFestivas($eventosRegistrados, $incluirVacaciones);
        $lunesInicio = self::lunesDeSemana($inicio);
        $lunesFin = self::lunesDeSemana($fin);

        if ($lunesFin->lt($lunesInicio)) {
            return 0;
        }

        $count = 0;
        $lunes = $lunesInicio->copy();

        while ($lunes->lte($lunesFin)) {
            if (!isset($festivas[$lunes->format('Y-m-d')])) {
                $count++;
            }
            $lunes->addWeek();
        }

        return $count;
    }
}
