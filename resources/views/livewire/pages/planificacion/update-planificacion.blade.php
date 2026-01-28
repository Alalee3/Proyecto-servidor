<div>
    <style>
        /* Estilos para inputs de fecha en modo oscuro */
        .date-input-dark::-webkit-calendar-picker-indicator {
            background: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20' fill='%23d1d5db'%3e%3cpath fill-rule='evenodd' d='M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z' clip-rule='evenodd'/%3e%3c/svg%3e") no-repeat center;
            background-size: 20px 20px;
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .date-input-dark::-webkit-datetime-edit-text {
            color: #d1d5db !important;
        }

        .date-input-dark::-webkit-datetime-edit-month-field,
        .date-input-dark::-webkit-datetime-edit-day-field,
        .date-input-dark::-webkit-datetime-edit-year-field {
            color: #d1d5db !important;
        }

        /* Estilos para el date picker desplegable */
        .date-input-dark::-webkit-datetime-edit {
            color: #d1d5db !important;
        }

        /* Estilos para el calendario desplegable */
        .date-input-dark::-webkit-calendar-picker-indicator:hover {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        /* Forzar tema claro en el date picker */
        .date-input-dark {
            color-scheme: light;
        }

        /* Estilos adicionales para el date picker */
        .date-input-dark::-webkit-datetime-edit-fields-wrapper {
            background-color: transparent;
        }

        .date-input-dark::-webkit-datetime-edit-text {
            color: #d1d5db !important;
            background-color: transparent;
        }

        .date-input-dark::-webkit-datetime-edit-month-field,
        .date-input-dark::-webkit-datetime-edit-day-field,
        .date-input-dark::-webkit-datetime-edit-year-field {
            color: #d1d5db !important;
            background-color: transparent;
        }

        /* Fallback para otros navegadores */
        .date-input-dark::-moz-calendar-picker-indicator {
            filter: invert(1);
        }

        .date-input-dark::-ms-calendar-picker-indicator {
            filter: invert(1);
        }
    </style>

    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-500 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Editar Planificación Académica') }}
        </h2>
    </x-slot>

    <div class="p-6 bg-white dark:bg-gray-800 shadow-md rounded-lg">
        <form wire:submit.prevent="savePlanificacion">
            <div class="space-y-4">

                @if (session()->has('message'))
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4
                                                                             dark:bg-green-700 dark:border-green-800 dark:text-green-100"
                        role="alert">
                        <span class="block sm:inline">{{ session('message') }}</span>
                    </div>
                @endif

                @if (session()->has('error'))
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4
                                                                             dark:bg-red-700 dark:border-red-800 dark:text-red-100"
                        role="alert">
                        <span class="block sm:inline">{{ session('error') }}</span>
                    </div>
                @endif

                {{-- Mostrar el nombre del docente de forma compacta --}}
                <div class="mb-4 p-3 bg-blue-50 dark:bg-blue-900 rounded-lg flex justify-between items-center">
                    <p class="text-sm text-blue-800 dark:text-blue-200">
                        <strong>Docente:</strong> {{ $docente_nombre }} {{ $docente_apellido }} - C.I: {{ $cedula }}
                    </p>
                    <span
                        class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-800 dark:text-blue-100">
                        Planificación #{{ $planificacionId }}
                    </span>
                </div>

                <!-- Sección de Cortes -->
                <div class="space-y-6" x-data="{ openCorte: 0 }">
                    <div class="flex items-center justify-between border-b border-gray-300 dark:border-gray-600 pb-4">
                        <h2 class="text-xl font-bold text-gray-800 dark:text-gray-100">
                            Definición de Cortes
                        </h2>
                        <div class="flex gap-2">
                            @foreach ($cortes as $idx => $c)
                                <button type="button" @click="openCorte = {{ $idx }}"
                                    :class="openCorte === {{ $idx }} ? 'bg-blue-600 text-white' : 'bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-300'"
                                    class="w-8 h-8 rounded-full flex items-center justify-center font-bold transition-all duration-200 text-sm shadow-sm">
                                    {{ $idx + 1 }}
                                </button>
                            @endforeach
                        </div>
                    </div>

                    @foreach ($cortes as $index => $corte)
                        @php
                            $totalPonderacion = $this->getTotalPonderacionForCorte($index);
                            $validPonderacion = abs($totalPonderacion - 25) < 0.01;
                        @endphp

                        <div class="border border-gray-200 dark:border-gray-700 rounded-xl overflow-hidden shadow-sm transition-all duration-300"
                             :class="openCorte === {{ $index }} ? 'ring-2 ring-blue-500 ring-opacity-50' : ''">
                            
                            <!-- Cabecera del Accordion -->
                            <button type="button" @click="openCorte = openCorte === {{ $index }} ? null : {{ $index }}"
                                class="w-full flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700/50 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors">
                                <div class="flex items-center gap-3">
                                    <span class="flex items-center justify-center w-8 h-8 rounded-full bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 font-bold text-sm">
                                        {{ $index + 1 }}
                                    </span>
                                    <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                                        Corte {{ $corte['corte'] }}
                                    </h3>
                                    @if ($corte['ultimo_motivo_rechazo'])
                                        <span class="ml-2 text-[10px] bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400 px-2 py-0.5 rounded-full font-bold uppercase">
                                            Rechazado
                                        </span>
                                    @endif
                                </div>
                                <div class="flex items-center gap-4">
                                    <div class="flex items-center gap-2">
                                        <span class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Ponderación:</span>
                                        <span class="text-sm font-bold {{ $validPonderacion ? 'text-green-600 dark:text-green-400' : 'text-red-600' }}">
                                            {{ $totalPonderacion }}% / 25%
                                        </span>
                                    </div>
                                    <svg class="w-5 h-5 text-gray-400 transform transition-transform duration-300" 
                                         :class="openCorte === {{ $index }} ? 'rotate-180' : ''"
                                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                    </svg>
                                </div>
                            </button>

                            <!-- Contenido del Accordion -->
                            <div x-show="openCorte === {{ $index }}" x-collapse>
                                <div class="p-6 bg-white dark:bg-gray-800 space-y-8">
                                    @if ($corte['ultimo_motivo_rechazo'])
                                        <div class="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg">
                                            <p class="text-xs text-red-700 dark:text-red-400 font-bold uppercase mb-1">Motivo de rechazo:</p>
                                            <p class="text-sm text-red-600 dark:text-red-300 italic">"{{ $corte['ultimo_motivo_rechazo'] }}"</p>
                                        </div>
                                    @endif

                                    {{-- Contenidos --}}
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider flex items-center gap-2">
                                                <span class="material-icons text-blue-500 text-lg">menu_book</span>
                                                Contenidos y Temas
                                            </h4>
                                            <button type="button" wire:click="addItem({{ $index }}, 'contenidos')"
                                                class="inline-flex items-center gap-1 text-xs bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 px-3 py-1.5 rounded-lg font-bold hover:bg-blue-100 transition-colors">
                                                <span class="material-icons text-sm">add</span>
                                                AÑADIR CONTENIDO
                                            </button>
                                        </div>

                                        @foreach ($corte['contenidos'] as $contenidoIndex => $contenido)
                                            <div class="p-4 rounded-xl bg-gray-50 dark:bg-gray-900/40 border border-gray-100 dark:border-gray-700/50 space-y-4">
                                                <div class="grid grid-cols-1 xl:grid-cols-2 gap-6">
                                                    {{-- Columna de Contenido --}}
                                                    <div class="space-y-2">
                                                        <div class="flex items-center justify-between">
                                                            <label class="text-xs font-bold text-gray-500 dark:text-gray-400 uppercase">Tema a desarrollar</label>
                                                            @if (count($corte['contenidos']) > 1)
                                                                <button type="button" wire:click="removeItem({{ $index }}, 'contenidos', {{ $contenidoIndex }})"
                                                                    class="text-red-500 hover:text-red-700 text-[10px] font-bold uppercase flex items-center gap-1">
                                                                    <span class="material-icons text-xs">delete</span> ELIMINAR
                                                                </button>
                                                            @endif
                                                        </div>
                                                        <x-select :options="$contenidosDisponibles" valueField="id_contenido"
                                                            textField="titulo_contenido"
                                                            wire:model.live.debounce.250ms="cortes.{{ $index }}.contenidos.{{ $contenidoIndex }}.contenido_id"
                                                            placeholder="Seleccione un contenido" class="text-sm w-full" />
                                                        @error("cortes.$index.contenidos.$contenidoIndex.contenido_id")
                                                            <p class="mt-1 text-[11px] text-red-600">{{ $message }}</p>
                                                        @enderror
                                                    </div>

                                                    {{-- Columna de Indicadores --}}
                                                    <div class="space-y-2">
                                                        <div class="flex items-center justify-between">
                                                            <label class="text-xs font-bold text-gray-500 dark:text-gray-400 uppercase">Indicadores de Logro</label>
                                                            <button type="button" wire:click="addItem({{ $index }}, 'indicadores_logros', {{ $contenidoIndex }})"
                                                                class="text-blue-600 dark:text-blue-400 hover:underline text-[10px] font-bold uppercase flex items-center gap-1">
                                                                <span class="material-icons text-xs">add_circle</span> AÑADIR
                                                            </button>
                                                        </div>

                                                        <div class="space-y-2">
                                                            @forelse ($contenido['indicadores_logros'] as $indicadorIndex => $indicador)
                                                                <div class="flex items-center gap-2">
                                                                    <div class="flex-grow">
                                                                        <x-select :options="$indicadoresDisponibles" valueField="id_indicador_logro"
                                                                            textField="nombre_indicador_logro"
                                                                            wire:model.live.debounce.250ms="cortes.{{ $index }}.contenidos.{{ $contenidoIndex }}.indicadores_logros.{{ $indicadorIndex }}.indicador_id"
                                                                            placeholder="Seleccione un indicador" class="text-sm w-full" />
                                                                    </div>
                                                                    @if (count($contenido['indicadores_logros']) > 1)
                                                                        <button type="button" wire:click="removeItem({{ $index }}, 'indicadores_logros', {{ $indicadorIndex }}, {{ $contenidoIndex }})"
                                                                            class="text-gray-400 hover:text-red-500 transition-colors">
                                                                            <span class="material-icons text-sm">remove_circle_outline</span>
                                                                        </button>
                                                                    @endif
                                                                </div>
                                                                @error("cortes.$index.contenidos.$contenidoIndex.indicadores_logros.$indicadorIndex.indicador_id")
                                                                    <p class="mt-1 text-[11px] text-red-600">{{ $message }}</p>
                                                                @enderror
                                                            @empty
                                                                <p class="text-xs text-gray-500 dark:text-gray-400 italic">No hay indicadores añadidos.</p>
                                                            @endforelse
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>

                                    {{-- Recursos y Estrategias --}}
                                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                        <div class="space-y-4">
                                            <div class="flex items-center justify-between">
                                                <h4 class="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider flex items-center gap-2">
                                                    <span class="material-icons text-amber-500 text-lg">inventory_2</span>
                                                    Recursos
                                                </h4>
                                                <button type="button" wire:click="addItem({{ $index }}, 'recursos')"
                                                    class="text-blue-600 dark:text-blue-400 hover:underline text-[10px] font-bold uppercase flex items-center gap-1">
                                                    <span class="material-icons text-xs">add_circle</span> AÑADIR
                                                </button>
                                            </div>
                                            <div class="grid grid-cols-1 gap-2">
                                                @foreach ($corte['recursos'] as $recursoIndex => $recurso)
                                                    <div class="flex items-center gap-2">
                                                        <div class="flex-grow">
                                                            <x-select :options="$recursosDisponibles" valueField="id_recurso"
                                                                textField="nombre_recurso"
                                                                wire:model.live.debounce.250ms="cortes.{{ $index }}.recursos.{{ $recursoIndex }}.recurso_id"
                                                                placeholder="Seleccione un recurso" class="text-sm w-full" />
                                                        </div>
                                                        @if (count($corte['recursos']) > 1)
                                                            <button type="button" wire:click="removeItem({{ $index }}, 'recursos', {{ $recursoIndex }})"
                                                                class="text-gray-400 hover:text-red-500 transition-colors">
                                                                <span class="material-icons text-sm">delete</span>
                                                            </button>
                                                        @endif
                                                    </div>
                                                    @error("cortes.$index.recursos.$recursoIndex.recurso_id")
                                                        <p class="mt-1 text-[11px] text-red-600">{{ $message }}</p>
                                                    @enderror
                                                @endforeach
                                            </div>
                                        </div>

                                        <div class="space-y-4">
                                            <div class="flex items-center justify-between">
                                                <h4 class="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider flex items-center gap-2">
                                                    <span class="material-icons text-purple-500 text-lg">psychology</span>
                                                    Estrategias
                                                </h4>
                                                <button type="button" wire:click="addItem({{ $index }}, 'estrategias')"
                                                    class="text-blue-600 dark:text-blue-400 hover:underline text-[10px] font-bold uppercase flex items-center gap-1">
                                                    <span class="material-icons text-xs">add_circle</span> AÑADIR
                                                </button>
                                            </div>
                                            <div class="grid grid-cols-1 gap-2">
                                                @foreach ($corte['estrategias'] as $estrategiaIndex => $estrategia)
                                                    <div class="flex items-center gap-2">
                                                        <div class="flex-grow">
                                                            <x-select :options="$estrategiasDisponibles" valueField="id_estrategia_pedagogica"
                                                                textField="nombre_estrategia_pedagogica"
                                                                wire:model.live.debounce.250ms="cortes.{{ $index }}.estrategias.{{ $estrategiaIndex }}.estrategia_id"
                                                                placeholder="Seleccione una estrategia" class="text-sm w-full" />
                                                        </div>
                                                        @if (count($corte['estrategias']) > 1)
                                                            <button type="button" wire:click="removeItem({{ $index }}, 'estrategias', {{ $estrategiaIndex }})"
                                                                class="text-gray-400 hover:text-red-500 transition-colors">
                                                                <span class="material-icons text-sm">delete</span>
                                                            </button>
                                                        @endif
                                                    </div>
                                                    @error("cortes.$index.estrategias.$estrategiaIndex.estrategia_id")
                                                        <p class="mt-1 text-[11px] text-red-600">{{ $message }}</p>
                                                    @enderror
                                                @endforeach
                                            </div>
                                        </div>
                                    </div>

                                    {{-- Plan de Evaluación --}}
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider flex items-center gap-2">
                                                <span class="material-icons text-green-500 text-lg">assignment_turned_in</span>
                                                Plan de Evaluación
                                            </h4>
                                            <button type="button" wire:click="addItem({{ $index }}, 'evaluaciones')"
                                                class="inline-flex items-center gap-1 text-xs bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 px-3 py-1.5 rounded-lg font-bold hover:bg-green-100 transition-colors">
                                                <span class="material-icons text-sm">add</span>
                                                AÑADIR EVALUACIÓN
                                            </button>
                                        </div>

                                        <div class="overflow-x-auto rounded-xl border border-gray-100 dark:border-gray-700">
                                            <table class="w-full text-xs text-left">
                                                <thead class="bg-gray-50 dark:bg-gray-900/60 text-gray-500 dark:text-gray-400 uppercase font-bold">
                                                    <tr>
                                                        <th class="px-4 py-3">Fecha</th>
                                                        <th class="px-4 py-3">Evaluación</th>
                                                        <th class="px-4 py-3">Técnica</th>
                                                        <th class="px-4 py-3">Pond. (%)</th>
                                                        <th class="px-4 py-3">Participación</th>
                                                        <th class="px-4 py-3"></th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                                                    @foreach ($corte['evaluaciones'] as $evaluacionIndex => $evaluacion)
                                                        <tr>
                                                            <td class="px-4 py-3">
                                                                <input type="date" wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.fecha_evaluacion"
                                                                    class="w-full bg-transparent border-0 focus:ring-0 p-0 text-gray-700 dark:text-gray-300 text-xs">
                                                            </td>
                                                            <td class="px-4 py-3">
                                                                <select wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.evaluacion_id"
                                                                    class="w-full bg-transparent border-0 focus:ring-0 p-0 text-gray-700 dark:text-gray-300 text-xs">
                                                                    <option value="">Seleccione</option>
                                                                    @foreach ($evaluacionesDisponibles as $eval)
                                                                        <option value="{{ $eval->id_evaluacion }}">{{ $eval->nombre_evaluacion }}</option>
                                                                    @endforeach
                                                                </select>
                                                            </td>
                                                            <td class="px-4 py-3">
                                                                <select wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.tecnica_id"
                                                                    class="w-full bg-transparent border-0 focus:ring-0 p-0 text-gray-700 dark:text-gray-300 text-xs">
                                                                    <option value="">Seleccione</option>
                                                                    @foreach ($tecnicasDisponibles as $tec)
                                                                        <option value="{{ $tec->id_tecnica }}">{{ $tec->nombre_tecnica }}</option>
                                                                    @endforeach
                                                                </select>
                                                            </td>
                                                            <td class="px-4 py-3">
                                                                <input type="number" step="0.5" min="1" max="25" wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.ponderacion"
                                                                    class="w-16 bg-transparent border-0 focus:ring-0 p-0 text-gray-700 dark:text-gray-300 text-xs font-bold">
                                                            </td>
                                                            <td class="px-4 py-3">
                                                                <select wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.forma_participacion"
                                                                    class="w-full bg-transparent border-0 focus:ring-0 p-0 text-gray-700 dark:text-gray-300 text-xs">
                                                                    <option value="">Seleccione</option>
                                                                    <option value="1">Individual</option>
                                                                    <option value="2">Pareja</option>
                                                                    <option value="3">Grupal</option>
                                                                </select>
                                                            </td>
                                                            <td class="px-4 py-3 text-right">
                                                                @if (count($corte['evaluaciones']) > 1)
                                                                    <button type="button" wire:click="removeItem({{ $index }}, 'evaluaciones', {{ $evaluacionIndex }})"
                                                                        class="text-gray-400 hover:text-red-500">
                                                                        <span class="material-icons text-sm">delete</span>
                                                                    </button>
                                                                @endif
                                                            </td>
                                                        </tr>
                                                        @error("cortes.$index.evaluaciones.$evaluacionIndex.fecha_evaluacion")
                                                        <tr><td colspan="6" class="px-4 py-0 text-[10px] text-red-500">{{ $message }}</td></tr>
                                                        @enderror
                                                        @error("cortes.$index.evaluaciones.$evaluacionIndex.evaluacion_id")
                                                        <tr><td colspan="6" class="px-4 py-0 text-[10px] text-red-500">{{ $message }}</td></tr>
                                                        @enderror
                                                        @error("cortes.$index.evaluaciones.$evaluacionIndex.tecnica_id")
                                                        <tr><td colspan="6" class="px-4 py-0 text-[10px] text-red-500">{{ $message }}</td></tr>
                                                        @enderror
                                                        @error("cortes.$index.evaluaciones.$evaluacionIndex.ponderacion")
                                                        <tr><td colspan="6" class="px-4 py-0 text-[10px] text-red-500">{{ $message }}</td></tr>
                                                        @enderror
                                                        @error("cortes.$index.evaluaciones.$evaluacionIndex.forma_participacion")
                                                        <tr><td colspan="6" class="px-4 py-0 text-[10px] text-red-500">{{ $message }}</td></tr>
                                                        @enderror
                                                    @endforeach
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    {{-- Navegación entre acordeones --}}
                                    <div class="flex justify-between items-center pt-4">
                                        <div>
                                            @if ($index > 0)
                                                <button type="button" @click="openCorte = {{ $index - 1 }}"
                                                    class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-gray-700 font-medium transition-colors">
                                                    <span class="material-icons text-sm">arrow_back</span> Corte Anterior
                                                </button>
                                            @endif
                                        </div>
                                        <div>
                                            @if ($index < count($cortes) - 1)
                                                <button type="button" @click="openCorte = {{ $index + 1 }}"
                                                    class="inline-flex items-center gap-2 px-6 py-2 bg-blue-600 text-white rounded-lg text-sm font-bold shadow-lg shadow-blue-500/30 hover:bg-blue-700 transition-all">
                                                    Siguiente Corte <span class="material-icons text-sm">arrow_forward</span>
                                                </button>
                                            @else
                                                <div class="text-xs text-gray-400 italic">Último corte de planificación</div>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach



                    <div class="bg-white dark:bg-gray-800 shadow-md rounded-lg p-6 mb-6">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                            <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">Bibliografía</h3>
                            <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                <button type="button" wire:click="addItem(null, 'bibliografias')"
                                    class="text-xs bg-blue-500 text-white px-2 py-1 rounded uppercase font-bold hover:bg-blue-600">
                                    Añadir Bibliografía
                                </button>
                            </div>
                        </div>

                        @foreach ($bibliografias as $biblioIndex => $bibliografia)
                            <div class="flex flex-col sm:flex-row sm:items-center gap-4 mb-4">
                                <div class="flex-grow min-w-0">
                                    <x-select label="Seleccionar Bibliografía" :options="$bibliografiasDisponibles"
                                        valueField="id_bibliografia" textField="nombre_bibliografia"
                                        wire:model.live.debounce.250ms="bibliografias.{{ $biblioIndex }}.bibliografia_id" />
                                    @error("bibliografias.$biblioIndex.bibliografia_id")
                                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                    @enderror
                                </div>
                                @if (count($bibliografias) > 1)
                                    <button type="button" wire:click="removeItem(null, 'bibliografias', {{ $biblioIndex }})"
                                        class="text-red-500 hover:text-red-700 text-sm self-start sm:self-auto p-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                @endif
                            </div>
                        @endforeach
                    </div>

                    <!-- Botones de Acción -->
                    <div class="flex justify-end gap-4">
                        <a href="{{ route('dashboard') }}"
                            class="inline-flex items-center px-5 py-2.5 bg-gray-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-gray-700 focus:outline-none transition ease-in-out duration-150">
                            Cancelar
                        </a>
                        <button type="submit"
                            class="inline-flex items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed">
                            <i class="fas fa-save mr-2"></i> Guardar Planificación
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>