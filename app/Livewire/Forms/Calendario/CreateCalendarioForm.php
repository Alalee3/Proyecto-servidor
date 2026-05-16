<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Illuminate\Support\Facades\DB;

class CreateCalendarioForm extends Form
{
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    // Propiedades para registro rápido de eventos
    public $nombreEventoTemporal = '';
    public $nuevoColorId = '';
    public $nuevoTipo = '1';
    public $nuevoLaborable = false;
    public $nuevoRepetible = false;
    public $nuevoIsRangoDias = false;
    public $nuevoRangoDias = '';
    public $tipo_calendario = '1'; // Nuevo: 1 (Semestral), 2 (Anual)
    public $idEventoTemporal = null; // Para cuando se edite un evento existente
    public $isCreatingEvento = false; // Controlar si se están aplicando las validaciones de creación rápida

    public function rules()
    {
        $rules = [
            'tipo_calendario' => ['required', 'in:1,2'],
            'dia_inicio_calendario_academico' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $dayOfWeek = date('N', strtotime($value));
                    if ($dayOfWeek >= 6) {
                        $fail('El período no puede comenzar un fin de semana.');
                    }
                },
            ],
            'dia_fin_calendario_academico' => [
                'required',
                'date',
                'after_or_equal:dia_inicio_calendario_academico',
                function ($attribute, $value, $fail) {
                    $dayOfWeek = date('N', strtotime($value));
                    if ($dayOfWeek >= 6) {
                        $fail('El período no puede finalizar un fin de semana.');
                    }
                },
            ],
        ];

        if ($this->isCreatingEvento) {
            $eventRules = [
                'nombreEventoTemporal' => [
                    'required',
                    'string',
                    'max:100',
                    function ($attribute, $value, $fail) {
                        $repo = new \App\Repositories\Calendario\CalendarioCreateRepo();
                        if ($repo->existeEventoConNombre($value, $this->idEventoTemporal)) {
                            $fail($this->idEventoTemporal ? 'Ya existe otro evento con esta descripción.' : 'Ya existe un evento con esta descripción.');
                        }
                    },
                    'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s\.,\-\(\)\"\':\/]+$/u'
                ],
                'nuevoTipo' => ['required', 'in:1,2,3,4,5'],
                'nuevoLaborable' => [
                    'required',
                    'boolean',
                    function ($attribute, $value, $fail) {
                        if (($this->nuevoTipo == '1' || $this->nuevoTipo == '2') && $value) {
                            $fail('Un feriado no puede ser marcado como laborable.');
                        }
                    }
                ],
                'nuevoRepetible' => [
                    'required',
                    'boolean',
                    function ($attribute, $value, $fail) {
                        if (($this->nuevoTipo == '1' || $this->nuevoTipo == '2') && $value) {
                            $fail('Un feriado no puede ser marcado como repetible.');
                        }
                    }
                ],
                'nuevoIsRangoDias' => ['required', 'boolean'],
                'nuevoRangoDias' => [
                    'nullable',
                    'required_if:nuevoIsRangoDias,true',
                    'numeric',
                    'min:1',
                    'max:90'
                ],
                'nuevoColorId' => [
                    'required',
                    'exists:color,id_color',
                    function ($attribute, $value, $fail) {
                        $repo = new \App\Repositories\Calendario\CalendarioCreateRepo();
                        if ($repo->existeEventoConColor($value, $this->idEventoTemporal)) {
                            $fail('Este color ya está asignado a otro evento activo.');
                        }
                    }
                ],
            ];
            $rules = array_merge($rules, $eventRules);
        }

        return $rules;
    }

    public function messages()
    {
        return [
            'dia_inicio_calendario_academico.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_calendario_academico.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin_calendario_academico.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_calendario_academico.date' => 'La fecha de fin debe ser válida.',
            'dia_fin_calendario_academico.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la de inicio.',
            // Mensajes para registro rápido
            'nombreEventoTemporal.required' => 'La descripción es obligatoria.',
            'nombreEventoTemporal.max' => 'La descripción no debe exceder 100 caracteres.',
            'nombreEventoTemporal.regex' => 'Formato inválido en la descripción.',
            'nuevoTipo.required' => 'El tipo de evento es obligatorio.',
            'nuevoColorId.required' => 'El color es obligatorio.',
        ];
    }

    /**
     * Valida el nombre de un evento y su tipo basándose en las reglas de seguridad y BD.
     */
    public function validarEvento($nombre, $tipo)
    {
        $reglas = [
            'nombre' => [
                'required',
                'string',
                'max:255',
                'regex:/^[A-Za-z0-9áéíóúÁÉÍÓÚñÑüÜ\d\s\.\,\-\(\)\"\':\/]+$/u'
            ],
            'tipo' => [
                'required',
                'in:1,2,3,4,5'
            ],
        ];

        $mensajes = [
            'nombre.required' => 'El nombre del evento es obligatorio.',
            'nombre.regex' => 'El nombre contiene caracteres no permitidos.',
            'tipo.required' => 'El tipo de evento es obligatorio.',
            'tipo.in' => 'El tipo de evento seleccionado no es válido en el sistema.',
        ];

        \Illuminate\Support\Facades\Validator::make(
            ['nombre' => $nombre, 'tipo' => $tipo],
            $reglas,
            $mensajes
        )->validate();
    }

    /**
     * Valida únicamente la sección de fechas del período.
     */
    public function validarSeccionFechas()
    {
        $allRules = $this->rules();
        $this->validate([
            'dia_inicio_calendario_academico' => $allRules['dia_inicio_calendario_academico'],
            'dia_fin_calendario_academico' => $allRules['dia_fin_calendario_academico'],
            'tipo_calendario' => $allRules['tipo_calendario'],
        ]);

        // Cálculo de Semanas (Normalizado a Lunes-Domingo para Tipo 1)
        $inicioNorm = \Carbon\Carbon::parse($this->dia_inicio_calendario_academico)->startOfWeek();
        $finNorm = \Carbon\Carbon::parse($this->dia_fin_calendario_academico)->endOfWeek();
        $semanasNorm = (int) ceil($inicioNorm->diffInDays($finNorm->addDay(1)) / 7);

        // Cálculo de Días Exactos (Para Tipo 2)
        $inicioReal = \Carbon\Carbon::parse($this->dia_inicio_calendario_academico);
        $finReal = \Carbon\Carbon::parse($this->dia_fin_calendario_academico);
        $diasReales = $inicioReal->diffInDays($finReal) + 1;

        if ($this->tipo_calendario == '1') {
            if ($semanasNorm != 18) {
                $msg = "Para un calendario SEMESTRAL, el período debe cubrir exactamente 18 semanas (actualmente cubre {$semanasNorm} semanas).";
                $this->addError('form.dia_fin_calendario_academico', $msg);
                throw \Illuminate\Validation\ValidationException::withMessages(['form.dia_fin_calendario_academico' => [$msg]]);
            }
        } else if ($this->tipo_calendario == '2') {
            // Determinar si el rango incluye un 29 de febrero
            $tieneBisiesto = false;
            $temp = clone $inicioReal;
            while ($temp <= $finReal) {
                if ($temp->month == 2 && $temp->day == 29) {
                    $tieneBisiesto = true;
                    break;
                }
                $temp->addMonth(); // Salto rápido para optimizar
                if ($temp->month > 2 && $temp->day > 29) $temp->subMonth()->addDay(); // Ajuste si se pasa
                else if ($temp->month == 2) {
                    $temp->startOfMonth(); // Asegurar que pase por febrero día a día
                    while($temp->month == 2 && $temp <= $finReal){
                        if($temp->day == 29) { $tieneBisiesto = true; break 2; }
                        $temp->addDay();
                    }
                }
            }
            
            $diasEsperados = $tieneBisiesto ? 366 : 365;

            if ($diasReales != $diasEsperados) {
                $detalle = $tieneBisiesto ? "(52 semanas + 2 días por ser bisiesto)" : "(52 semanas + 1 día)";
                $msg = "Para un calendario ANUAL, el período debe durar exactamente {$diasEsperados} días {$detalle}. Actualmente tiene {$diasReales} días.";
                $this->addError('form.dia_fin_calendario_academico', $msg);
                throw \Illuminate\Validation\ValidationException::withMessages(['form.dia_fin_calendario_academico' => [$msg]]);
            }
        }
    }

    /**
     * Realiza la validación completa del formulario incluyendo la lógica de eventos.
     */
    public function validarFormularioCompleto($eventosRegistrados)
    {
        $errores = [];

        // 1. Validar reglas básicas del objeto Form
        try {
            $this->validate();
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errores = array_merge($errores, array_values($e->errors()));
        }

        // 2. Validar que todos los eventos activos estén asignados (ahora todos son obligatorios)
        $eventosObligatorios = \App\Models\Evento::where('estatus', '1')
            ->get();

        $idsRegistrados = collect($eventosRegistrados)->pluck('id')->all();

        foreach ($eventosObligatorios as $obligatorio) {
            // 2.1 Validar que el evento esté registrado
            if (!in_array($obligatorio->id_evento, $idsRegistrados)) {
                $msg = "El evento \"{$obligatorio->nombre_evento}\" debe ser asignado al calendario antes de guardar.";
                $this->addError('eventosRegistrados', $msg);
                $errores[] = [$msg];
                continue;
            }

            // 2.2 Validar duración exacta si tiene rango de días específico
            if ($obligatorio->is_rango_dias_evento) {
                $totalDias = 0;
                foreach ($eventosRegistrados as $reg) {
                    if ($reg['id'] == $obligatorio->id_evento) {
                        $inicio = new \DateTime($reg['inicio']);
                        $fin = new \DateTime($reg['fin']);
                        // Calculamos la diferencia en días y sumamos 1 para incluir ambos extremos
                        $intervalo = $inicio->diff($fin);
                        $totalDias += $intervalo->days + 1;
                    }
                }

                if ($totalDias != $obligatorio->rango_dias_evento) {
                    $msg = "El evento \"{$obligatorio->nombre_evento}\" debe durar exactamente {$obligatorio->rango_dias_evento} días (actualmente tiene {$totalDias}).";
                    $this->addError('eventosRegistrados', $msg);
                    $errores[] = [$msg];
                }
            }
        }

        if (count($errores) > 0) {
            // Aplanar array de errores si es necesario
            $todosLosErrores = [];
            foreach ($errores as $err) {
                if (is_array($err)) {
                    foreach ($err as $e)
                        $todosLosErrores[] = $e;
                } else {
                    $todosLosErrores[] = $err;
                }
            }
            return ['valido' => false, 'errores' => $todosLosErrores];
        }

        return ['valido' => true, 'errores' => []];
    }
}
