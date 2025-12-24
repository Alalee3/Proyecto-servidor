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

                {{-- Docente --}}
                @if ($docente_nombre)
                    <div class="mb-4 p-3 bg-blue-50 dark:bg-blue-900 rounded-lg">
                        <p class="text-sm text-blue-800 dark:text-blue-200">
                            <strong>Docente:</strong> {{ $docente_nombre }} {{ $docente_apellido }} - Planificación Académica
                        </p>
                    </div>
                @endif

                <!-- Sección y Unidad Curricular -->
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <div>
                        <label class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Sección:</label>
                        <input type="text"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500 bg-gray-100"
                            value="{{ $seccionData->seccion ?? '' }}" readonly>
                    </div>
                    <div>
                        <label class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Unidad Curricular:</label>
                        <input type="text"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500 bg-gray-100"
                            value="{{ $nombre_unidad_curricular ?? '' }}" readonly>
                    </div>
                </div>

                <!-- Bibliografías -->
                <div class="mb-6">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-lg font-bold text-gray-800 dark:text-gray-200">Bibliografías</h3>
                        <button type="button" wire:click="addItem(null, 'bibliografias')"
                            class="inline-flex items-center px-5 py-2.5 bg-green-600 dark:bg-green-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-green-700 dark:hover:bg-green-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-green-800 dark:disabled:bg-green-800 disabled:opacity-75 disabled:cursor-not-allowed">
                            <i class="fas fa-plus mr-2"></i> AÑADIR BIBLIOGRAFÍA
                        </button>
                    </div>
                    <div class="space-y-3">
                        @foreach ($bibliografias as $i => $biblio)
                            <div class="bg-transparent dark:bg-transparent p-4 rounded-lg border dark:border-gray-600">
                                <div class="flex items-center gap-3">
                                    <select wire:model.live.debounce.250ms="bibliografias.{{ $i }}.bibliografia_id"
                                        class="flex-1 shadow appearance-none border rounded py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                                           dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                        <option value="">-- Seleccione una bibliografía --</option>
                                        @foreach ($bibliografiasDisponibles as $op)
                                            <option value="{{ $op->bibliografia_id }}">
                                                {{ $op->titulo ?? ($op->bibliografia ?? 'Bibliografía') }}</option>
                                        @endforeach
                                    </select>
                                    <button type="button" wire:click="removeItem(null, 'bibliografias', {{ $i }})"
                                        class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                                @error('bibliografias.' . $i . '.bibliografia_id')
                                    <span class="text-red-500 text-xs italic dark:text-red-400 mt-1 block">{{ $message }}</span>
                                @enderror
                            </div>
                        @endforeach
                    </div>
                </div>

                <!-- Cortes -->
                <div class="space-y-6">
                    <h2 class="text-xl font-bold pb-4 text-gray-800 dark:text-gray-100 border-b border-gray-300 dark:border-gray-600">Definición de Cortes</h2>
                    @foreach ($cortes as $corteIndex => $corte)
                        <div class="rounded-lg p-6 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-600 mb-8 shadow-sm">
                            <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-6 gap-2 pb-4 border-b border-gray-300 dark:border-gray-600">
                                <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">Corte {{ $corte['corte'] }}</h3>
                                @if ($corte['ultimo_motivo_rechazo'])
                                    <span class="text-sm text-red-500 font-medium bg-red-50 dark:bg-red-900 px-2 py-1 rounded">Motivo rechazo: {{ $corte['ultimo_motivo_rechazo'] }}</span>
                                @endif
                            </div>

                    <!-- Contenidos e Indicadores -->
                    <div class="mb-6">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                            <h4 class="font-medium text-gray-800 dark:text-gray-100">Contenidos</h4>
                            <button type="button" wire:click="addItem({{ $corteIndex }}, 'contenidos')"
                                class="inline-flex items-center px-5 py-2.5 bg-green-600 dark:bg-green-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-green-700 dark:hover:bg-green-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-green-800 dark:disabled:bg-green-800 disabled:opacity-75 disabled:cursor-not-allowed">
                                <i class="fas fa-plus mr-2"></i> AÑADIR CONTENIDO
                            </button>
                        </div>
                        @foreach ($corte['contenidos'] as $contIdx => $contenido)
                            <div class="space-y-4 mb-6">
                                <div class="grid grid-cols-1 xl:grid-cols-2 gap-4">
                                    <!-- Contenido -->
                                    <div class="min-w-0">
                                        <div
                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                            <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">Contenido
                                            </h5>
                                            @if (count($corte['contenidos']) > 1)
                                                <button type="button"
                                                    wire:click="removeItem({{ $corteIndex }}, 'contenidos', {{ $contIdx }})"
                                                    class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            @endif
                                        </div>
                                        <select
                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.contenidos.{{ $contIdx }}.contenido_id"
                                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                            <option value="">-- Seleccione un contenido --</option>
                                            @foreach ($contenidosDisponibles as $op)
                                                <option value="{{ $op->contenido_id ?? $op->id }}">
                                                    {{ $op->titulo ?? ($op->nombre ?? 'Contenido') }}</option>
                                            @endforeach
                                        </select>
                                        @error('cortes.' . $corteIndex . '.contenidos.' . $contIdx . '.contenido_id')
                                            <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                        @enderror
                                    </div>
                                    <!-- Indicadores de Logro -->
                                    <div class="min-w-0">
                                        <div
                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                            <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">Indicadores
                                                de Logro</h5>
                                            <button type="button"
                                                wire:click="addItem({{ $corteIndex }}, 'indicadores_logros', {{ $contIdx }})"
                                                class="text-xs bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600">+
                                                AÑADIR INDICADOR</button>
                                        </div>
                                        @foreach ($contenido['indicadores_logros'] as $indIdx => $indicador)
                                            <div class="flex flex-col sm:flex-row gap-2 mb-2 items-start">
                                                <div class="flex-grow min-w-0">
                                                    <select
                                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.contenidos.{{ $contIdx }}.indicadores_logros.{{ $indIdx }}.indicador_id"
                                                        class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                                        <option value="">Seleccione un indicador</option>
                                                        @foreach ($indicadoresDisponibles as $op)
                                                            <option value="{{ $op->indicador_id ?? $op->id }}">
                                                                {{ $op->indicador ?? ($op->descripcion ?? 'Indicador') }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                @if (count($contenido['indicadores_logros']) > 1)
                                                    <button type="button"
                                                        wire:click="removeItem({{ $corteIndex }}, 'indicadores_logros', {{ $indIdx }}, {{ $contIdx }})"
                                                        class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                                        <i class="fas fa-trash mr-1"></i> ELIMINAR INDICADOR
                                                    </button>
                                                @endif
                                            </div>
                                            @error('cortes.' . $corteIndex . '.contenidos.' . $contIdx .
                                                '.indicadores_logros.' . $indIdx . '.indicador_id')
                                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                            @enderror
                                        @endforeach
                                    </div>
                                </div>
                                <hr class="my-4 border-gray-300 dark:border-gray-600">
                            </div>
                        @endforeach
                    </div>

                    <!-- Recursos y Estrategias -->
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                        <!-- Recursos -->
                        <div class="min-w-0">
                            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                <h4 class="font-medium text-gray-800 dark:text-gray-100">Recursos</h4>
                                <button type="button" wire:click="addItem({{ $corteIndex }}, 'recursos')"
                                    class="text-xs bg-blue-500 text-white px-2 py-1 rounded">AÑADIR RECURSO</button>
                            </div>
                            @foreach ($corte['recursos'] as $rIdx => $recurso)
                                <div class="flex flex-col sm:flex-row gap-2 mb-2">
                                    <div class="flex-grow min-w-0">
                                        <select
                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.recursos.{{ $rIdx }}.recurso_id"
                                            class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                            <option value="">Seleccione un recurso</option>
                                            @foreach ($recursosDisponibles as $op)
                                                <option value="{{ $op->recurso_id ?? $op->id }}">
                                                    {{ $op->nombre ?? ($op->recurso ?? 'Recurso') }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    @if (count($corte['recursos']) > 1)
                                        <button type="button"
                                            wire:click="removeItem({{ $corteIndex }}, 'recursos', {{ $rIdx }})"
                                            class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                            <i class="fas fa-trash mr-1"></i> ELIMINAR
                                        </button>
                                    @endif
                                </div>
                                @error('cortes.' . $corteIndex . '.recursos.' . $rIdx . '.recurso_id')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            @endforeach
                        </div>
                        <!-- Estrategias -->
                        <div class="min-w-0">
                            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                <h4 class="font-medium text-gray-800 dark:text-gray-100">Estrategias</h4>
                                <button type="button" wire:click="addItem({{ $corteIndex }}, 'estrategias')"
                                    class="text-xs bg-blue-500 text-white px-2 py-1 rounded">AÑADIR ESTRATEGIA</button>
                            </div>
                            @foreach ($corte['estrategias'] as $eIdx => $estrategia)
                                <div class="flex flex-col sm:flex-row gap-2 mb-2">
                                    <div class="flex-grow min-w-0">
                                        <select
                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.estrategias.{{ $eIdx }}.estrategia_id"
                                            class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                            <option value="">Seleccione una estrategia</option>
                                            @foreach ($estrategiasDisponibles as $op)
                                                <option value="{{ $op->estrategia_id ?? $op->id }}">
                                                    {{ $op->nombre ?? ($op->estrategia ?? 'Estrategia') }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    @if (count($corte['estrategias']) > 1)
                                        <button type="button"
                                            wire:click="removeItem({{ $corteIndex }}, 'estrategias', {{ $eIdx }})"
                                            class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                            <i class="fas fa-trash mr-1"></i> ELIMINAR
                                        </button>
                                    @endif
                                </div>
                                @error('cortes.' . $corteIndex . '.estrategias.' . $eIdx . '.estrategia_id')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            @endforeach
                        </div>
                    </div>

                    <!-- Evaluaciones -->
                    <div class="mb-6">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                            <h4 class="font-medium text-gray-800 dark:text-gray-100">Evaluaciones</h4>
                            <button type="button" wire:click="addItem({{ $corteIndex }}, 'evaluaciones')"
                                class="text-xs bg-blue-500 text-white px-2 py-1 rounded">AÑADIR EVALUACIÓN</button>
                        </div>
                        @foreach ($corte['evaluaciones'] as $evIdx => $evaluacion)
                            <div class="grid grid-cols-1 md:grid-cols-5 gap-2 mb-2 items-end">
                                <div>
                                    <select
                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.evaluacion_id"
                                        class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                        <option value="">Tipo...</option>
                                        @foreach ($evaluacionesDisponibles as $op)
                                            <option value="{{ $op->evaluacion_id ?? $op->id }}">
                                                {{ $op->nombre ?? ($op->evaluacion ?? 'Evaluación') }}</option>
                                        @endforeach
                                    </select>
                                    @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.evaluacion_id')
                                        <span class="text-red-600 text-xs">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div>
                                    <select
                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.tecnica_id"
                                        class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                        <option value="">Técnica...</option>
                                        @foreach ($tecnicasDisponibles as $op)
                                            <option value="{{ $op->tecnica_id ?? $op->id }}">
                                                {{ $op->nombre ?? ($op->tecnica ?? 'Técnica') }}</option>
                                        @endforeach
                                    </select>
                                    @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.tecnica_id')
                                        <span class="text-red-600 text-xs">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div>
                                    <input type="number" min="0" max="25" step="0.01"
                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.ponderacion"
                                        class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100"
                                        placeholder="% Ponderación">
                                    @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.ponderacion')
                                        <span class="text-red-600 text-xs">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div>
                                    <input type="date"
                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.fecha_evaluacion"
                                        class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                                           dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500
                                           date-input-dark"
                                        style="color-scheme: light;">
                                    @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.fecha_evaluacion')
                                        <span class="text-red-600 text-xs">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div>
                                    <select
                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.forma_participacion"
                                        class="text-sm w-full border-gray-300 rounded dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100">
                                        <option value="">Participación...</option>
                                        <option value="1">Individual</option>
                                        <option value="2">en pareja</option>
                                        <option value="3">grupal</option>
                                    </select>
                                    @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.forma_participacion')
                                        <span class="text-red-600 text-xs">{{ $message }}</span>
                                    @enderror
                                </div>
                                @if (count($corte['evaluaciones']) > 1)
                                    <button type="button"
                                        wire:click="removeItem({{ $corteIndex }}, 'evaluaciones', {{ $evIdx }})"
                                        class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold">
                                        <i class="fas fa-trash mr-1"></i> ELIMINAR
                                    </button>
                                @endif
                            </div>
                        @endforeach
                    </div>
                </div>
                
                @if (!$loop->last)
                    <!-- Separador entre cortes -->
                    <div class="flex items-center justify-center my-6">
                        <div class="flex-1 border-t border-gray-300 dark:border-gray-600"></div>
                        <div class="px-4 text-gray-500 dark:text-gray-400 text-sm font-medium">Corte {{ $corte['corte'] + 1 }}</div>
                        <div class="flex-1 border-t border-gray-300 dark:border-gray-600"></div>
                    </div>
                @endif
            @endforeach
        </div>

                <div class="flex justify-end gap-4 mt-8">
                    <a href="{{ route('planificacion/mis-planificaciones') }}"
                        class="inline-flex items-center px-5 py-2.5 bg-gray-600 dark:bg-gray-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-gray-700 dark:hover:bg-gray-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-gray-800 dark:disabled:bg-gray-800 disabled:opacity-75 disabled:cursor-not-allowed">
                        CANCELAR
                    </a>
                    <button type="submit"
                        class="inline-flex items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed">
                        <i class="fas fa-save mr-2"></i> GUARDAR PLANIFICACIÓN
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
