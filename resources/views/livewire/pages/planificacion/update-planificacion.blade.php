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
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight text-center">
            {{ __('Editar Planificación') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <form wire:submit.prevent="savePlanificacion">
                        <!-- Mensajes de Estado -->
                        @if (session()->has('message'))
                            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 dark:bg-green-700 dark:border-green-800 dark:text-green-100"
                                role="alert">
                                <span class="block sm:inline">{{ session('message') }}</span>
                            </div>
                        @endif

                        @if (session()->has('error'))
                            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4 dark:bg-red-700 dark:border-red-800 dark:text-red-100"
                                role="alert">
                                <span class="block sm:inline">{{ session('error') }}</span>
                            </div>
                        @endif

                        <!-- Información del Docente (Solo Lectura) -->
                        <div
                            class="mb-6 p-4 bg-gray-50 dark:bg-gray-700 rounded-lg shadow-sm border border-gray-200 dark:border-gray-600">
                            <h3 class="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-200 flex items-center">
                                <i class="fas fa-user-tie mr-2 text-blue-500"></i> Información del Docente y Unidad
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label
                                        class="block text-sm font-medium text-gray-500 dark:text-gray-400">Docente</label>
                                    <p class="mt-1 text-lg font-medium text-gray-900 dark:text-gray-100">
                                        {{ $docente_nombre }} {{ $docente_apellido }}
                                    </p>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">C.I: {{ $cedula }}</p>
                                </div>
                                <div class="md:text-right">
                                    <span
                                        class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200">
                                        Planificación #{{ $planificacionId }}
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Bibliografía -->
                        <div
                            class="mb-8 p-6 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-600 shadow-sm">
                            <div class="flex justify-between items-center mb-4">
                                <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">Bibliografía</h3>
                                <button type="button" wire:click="addItem(null, 'bibliografias')"
                                    class="inline-flex items-center px-4 py-2 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150">
                                    <i class="fas fa-plus mr-2"></i> Añadir Bibliografía
                                </button>
                            </div>
                            <div class="space-y-4">
                                @foreach ($bibliografias as $i => $bibliografia)
                                    <div class="flex items-center space-x-2">
                                        <div class="flex-1">
                                            <x-select label="Seleccionar Bibliografía" :options="$bibliografiasDisponibles"
                                                valueField="id_bibliografia" textField="nombre_bibliografia"
                                                wire:model.live.debounce.250ms="bibliografias.{{ $i }}.bibliografia_id" />
                                            @error('bibliografias.' . $i . '.bibliografia_id')
                                                <span
                                                    class="text-red-500 text-xs italic dark:text-red-400 mt-1 block">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <button type="button" wire:click="removeItem(null, 'bibliografias', {{ $i }})"
                                            class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold p-2">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                @endforeach
                            </div>
                        </div>

                        <!-- Sección de Cortes -->
                        <div class="space-y-8">
                            <h2
                                class="text-xl font-bold pb-4 text-gray-800 dark:text-gray-100 border-b border-gray-300 dark:border-gray-600">
                                Definición de Cortes
                            </h2>

                            @foreach ($cortes as $corteIndex => $corte)
                                <div
                                    class="rounded-lg p-6 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-600 shadow-sm">
                                    <!-- Cabecera del Corte -->
                                    <div
                                        class="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-6 gap-2 pb-4 border-b border-gray-300 dark:border-gray-600">
                                        <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                                            Corte {{ $corte['corte'] }}
                                        </h3>
                                        @if ($corte['ultimo_motivo_rechazo'])
                                            <span
                                                class="text-sm text-red-500 font-medium bg-red-50 dark:bg-red-900 px-2 py-1 rounded">
                                                Motivo rechazo: {{ $corte['ultimo_motivo_rechazo'] }}
                                            </span>
                                        @endif
                                    </div>

                                    <!-- Contenidos e Indicadores -->
                                    <div class="mb-8">
                                        <div
                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                                            <h4 class="font-medium text-gray-800 dark:text-gray-100">Contenidos</h4>
                                            <button type="button" wire:click="addItem({{ $corteIndex }}, 'contenidos')"
                                                class="inline-flex items-center px-4 py-2 bg-green-600 dark:bg-green-600 border border-transparent rounded-lg font-medium text-xs text-white uppercase tracking-widest hover:bg-green-700 dark:hover:bg-green-700 focus:outline-none transition ease-in-out duration-150">
                                                <i class="fas fa-plus mr-2"></i> Añadir Contenido
                                            </button>
                                        </div>

                                        @foreach ($corte['contenidos'] as $contIdx => $contenido)
                                            <div
                                                class="space-y-4 mb-6 pb-6 border-b border-gray-200 dark:border-gray-700 last:border-0">
                                                <div class="grid grid-cols-1 xl:grid-cols-2 gap-6">
                                                    <!-- Contenido -->
                                                    <div class="min-w-0 bg-white dark:bg-gray-700 p-4 rounded-lg shadow-sm">
                                                        <div
                                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                                            <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">
                                                                Contenido</h5>
                                                            @if (count($corte['contenidos']) > 1)
                                                                <button type="button"
                                                                    wire:click="removeItem({{ $corteIndex }}, 'contenidos', {{ $contIdx }})"
                                                                    class="text-red-500 hover:text-red-700 text-xs font-semibold uppercase">
                                                                    <i class="fas fa-times mr-1"></i> Eliminar
                                                                </button>
                                                            @endif
                                                        </div>
                                                        <x-select :options="$contenidosDisponibles" valueField="id_contenido"
                                                            textField="titulo_contenido"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.contenidos.{{ $contIdx }}.contenido_id"
                                                            placeholder="Seleccione un contenido" class="text-sm w-full" />
                                                        @error('cortes.' . $corteIndex . '.contenidos.' . $contIdx . '.contenido_id')
                                                            <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                        @enderror
                                                    </div>

                                                    <!-- Indicadores de Logro -->
                                                    <div class="min-w-0 bg-white dark:bg-gray-700 p-4 rounded-lg shadow-sm">
                                                        <div
                                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                                                            <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">
                                                                Indicadores de Logro</h5>
                                                            <button type="button"
                                                                wire:click="addItem({{ $corteIndex }}, 'indicadores_logros', {{ $contIdx }})"
                                                                class="inline-flex items-center px-3 py-1 bg-blue-500 text-white text-xs rounded hover:bg-blue-600 uppercase">
                                                                <i class="fas fa-plus mr-1"></i> Indicador
                                                            </button>
                                                        </div>
                                                        @foreach ($contenido['indicadores_logros'] as $indIdx => $indicador)
                                                            <div class="flex flex-col sm:flex-row gap-2 mb-3 items-start last:mb-0">
                                                                <div class="flex-grow min-w-0">
                                                                    <x-select :options="$indicadoresDisponibles"
                                                                        valueField="id_indicador_logro"
                                                                        textField="nombre_indicador_logro"
                                                                        wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.contenidos.{{ $contIdx }}.indicadores_logros.{{ $indIdx }}.indicador_id"
                                                                        placeholder="Seleccione un indicador"
                                                                        class="text-sm w-full" />
                                                                </div>
                                                                @if (count($contenido['indicadores_logros']) > 1)
                                                                    <button type="button"
                                                                        wire:click="removeItem({{ $corteIndex }}, 'indicadores_logros', {{ $indIdx }}, {{ $contIdx }})"
                                                                        class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto p-2">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                @endif
                                                            </div>
                                                            @error('cortes.' . $corteIndex . '.contenidos.' . $contIdx . '.indicadores_logros.' . $indIdx . '.indicador_id')
                                                                <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                            @enderror
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>

                                    <!-- Recursos y Estrategias -->
                                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                                        <!-- Recursos -->
                                        <div class="min-w-0 bg-white dark:bg-gray-700 p-4 rounded-lg shadow-sm">
                                            <div
                                                class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                                                <h4 class="font-medium text-gray-800 dark:text-gray-100">Recursos</h4>
                                                <button type="button" wire:click="addItem({{ $corteIndex }}, 'recursos')"
                                                    class="inline-flex items-center px-3 py-1 bg-blue-500 text-white text-xs rounded uppercase hover:bg-blue-600">
                                                    <i class="fas fa-plus mr-1"></i> Recurso
                                                </button>
                                            </div>
                                            @foreach ($corte['recursos'] as $rIdx => $recurso)
                                                <div class="flex flex-col sm:flex-row gap-2 mb-3 last:mb-0">
                                                    <div class="flex-grow min-w-0">
                                                        <x-select :options="$recursosDisponibles" valueField="id_recurso"
                                                            textField="nombre_recurso"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.recursos.{{ $rIdx }}.recurso_id"
                                                            placeholder="Seleccione un recurso" class="text-sm w-full" />
                                                    </div>
                                                    @if (count($corte['recursos']) > 1)
                                                        <button type="button"
                                                            wire:click="removeItem({{ $corteIndex }}, 'recursos', {{ $rIdx }})"
                                                            class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto p-2">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    @endif
                                                </div>
                                                @error('cortes.' . $corteIndex . '.recursos.' . $rIdx . '.recurso_id')
                                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                @enderror
                                            @endforeach
                                        </div>

                                        <!-- Estrategias -->
                                        <div class="min-w-0 bg-white dark:bg-gray-700 p-4 rounded-lg shadow-sm">
                                            <div
                                                class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                                                <h4 class="font-medium text-gray-800 dark:text-gray-100">Estrategias</h4>
                                                <button type="button" wire:click="addItem({{ $corteIndex }}, 'estrategias')"
                                                    class="inline-flex items-center px-3 py-1 bg-blue-500 text-white text-xs rounded uppercase hover:bg-blue-600">
                                                    <i class="fas fa-plus mr-1"></i> Estrategia
                                                </button>
                                            </div>
                                            @foreach ($corte['estrategias'] as $eIdx => $estrategia)
                                                <div class="flex flex-col sm:flex-row gap-2 mb-3 last:mb-0">
                                                    <div class="flex-grow min-w-0">
                                                        <x-select :options="$estrategiasDisponibles"
                                                            valueField="id_estrategia_pedagogica"
                                                            textField="nombre_estrategia_pedagogica"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.estrategias.{{ $eIdx }}.estrategia_id"
                                                            placeholder="Seleccione una estrategia" class="text-sm w-full" />
                                                    </div>
                                                    @if (count($corte['estrategias']) > 1)
                                                        <button type="button"
                                                            wire:click="removeItem({{ $corteIndex }}, 'estrategias', {{ $eIdx }})"
                                                            class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto p-2">
                                                            <i class="fas fa-trash"></i>
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
                                    <div class="mb-6 bg-white dark:bg-gray-700 p-4 rounded-lg shadow-sm">
                                        <div
                                            class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                                            <h4 class="font-medium text-gray-800 dark:text-gray-100">Evaluaciones</h4>
                                            <button type="button" wire:click="addItem({{ $corteIndex }}, 'evaluaciones')"
                                                class="inline-flex items-center px-4 py-2 bg-blue-500 text-white text-xs rounded uppercase hover:bg-blue-600">
                                                <i class="fas fa-plus mr-2"></i> Añadir Evaluación
                                            </button>
                                        </div>
                                        @foreach ($corte['evaluaciones'] as $evIdx => $evaluacion)
                                            <div
                                                class="p-4 mb-4 bg-gray-50 dark:bg-gray-800 rounded border border-gray-200 dark:border-gray-600">
                                                <!-- Fecha y Evaluación -->
                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                                                    <div class="min-w-0">
                                                        <label
                                                            class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Fecha
                                                            de Evaluación:</label>
                                                        <input type="date"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.fecha_evaluacion"
                                                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                                                                                   dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500
                                                                                   date-input-dark"
                                                            style="color-scheme: light;">
                                                        @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.fecha_evaluacion')
                                                            <span class="text-red-600 text-xs">{{ $message }}</span>
                                                        @enderror
                                                    </div>
                                                    <div class="min-w-0">
                                                        <x-select label="Tipo de Evaluación" :options="$evaluacionesDisponibles"
                                                            valueField="id_evaluacion" textField="nombre_evaluacion"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.evaluacion_id" />
                                                        @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.evaluacion_id')
                                                            <span class="text-red-600 text-xs">{{ $message }}</span>
                                                        @enderror
                                                    </div>
                                                </div>

                                                <!-- Ponderación, Técnica y Forma de Participación -->
                                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                                    <div class="min-w-0">
                                                        <label
                                                            class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Ponderación
                                                            (%)</label>
                                                        <input type="number" min="0" max="25" step="0.01"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.ponderacion"
                                                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600">
                                                        @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.ponderacion')
                                                            <span class="text-red-600 text-xs">{{ $message }}</span>
                                                        @enderror
                                                    </div>
                                                    <div class="min-w-0">
                                                        <x-select label="Técnica" :options="$tecnicasDisponibles"
                                                            valueField="id_tecnica" textField="nombre_tecnica"
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.tecnica_id" />
                                                        @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.tecnica_id')
                                                            <span class="text-red-600 text-xs">{{ $message }}</span>
                                                        @enderror
                                                    </div>
                                                    <div class="min-w-0">
                                                        <label
                                                            class="block text-sm font-medium mb-1 dark:text-gray-100">Participación</label>
                                                        <select
                                                            wire:model.live.debounce.250ms="cortes.{{ $corteIndex }}.evaluaciones.{{ $evIdx }}.forma_participacion"
                                                            class="w-full rounded border-gray-300 dark:bg-gray-800 dark:border-gray-900 dark:text-gray-100 text-sm">
                                                            <option value="">Seleccione</option>
                                                            <option value="1">Individual</option>
                                                            <option value="2">en pareja</option>
                                                            <option value="3">grupal</option>
                                                        </select>
                                                        @error('cortes.' . $corteIndex . '.evaluaciones.' . $evIdx . '.forma_participacion')
                                                            <span class="text-red-600 text-xs">{{ $message }}</span>
                                                        @enderror
                                                    </div>
                                                </div>

                                                @if (count($corte['evaluaciones']) > 1)
                                                    <div class="flex justify-end mt-4">
                                                        <button type="button"
                                                            wire:click="removeItem({{ $corteIndex }}, 'evaluaciones', {{ $evIdx }})"
                                                            class="text-red-500 hover:text-red-800 dark:text-red-400 dark:hover:text-red-600 text-sm font-semibold uppercase">
                                                            <i class="fas fa-trash mr-1"></i> Eliminar Evaluación
                                                        </button>
                                                    </div>
                                                @endif
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                            @endforeach
                        </div>

                        <div class="flex justify-end gap-4 mt-8">
                            <a href="{{ route('dashboard') }}"
                                class="inline-flex items-center px-5 py-2.5 bg-gray-600 dark:bg-gray-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-gray-700 dark:hover:bg-gray-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-gray-800 dark:disabled:bg-gray-800 disabled:opacity-75 disabled:cursor-not-allowed">
                                CANCELAR
                            </a>
                            <button type="submit"
                                class="inline-flex items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed">
                                <i class="fas fa-save mr-2"></i> GUARDAR PLANIFICACIÓN
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>