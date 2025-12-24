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
            {{ __('Crear Planificación Académica') }}
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
                @if ($docenteNombre)
                    <div class="mb-4 p-3 bg-blue-50 dark:bg-blue-900 rounded-lg">
                        <p class="text-sm text-blue-800 dark:text-blue-200">
                            <strong>Docente:</strong> {{ $docenteNombre }} - Planificación Académica
                        </p>
                    </div>
                @else
                    <div class="mb-4 p-3 bg-red-50 dark:bg-red-900 rounded-lg">
                        <p class="text-sm text-red-800 dark:text-red-200">
                            No se pudo identificar al docente o no tiene los permisos necesarios.
                        </p>
                    </div>
                @endif

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    {{-- Selección de Asignación (Materia y Sección) --}}
                    <div class="min-w-0">
                        <x-select label="Asignación (Materia y Sección)" :options="$asignaciones"
                            valueField="id_detalle_profesor_asignado" textField="descripcion_completa"
                            wire:model.live="id_profesor_asignado" placeholder="Seleccione una asignación" />

                    </div>

                    {{-- Campo para el Propósito de la Unidad Curricular --}}
                    <div class="min-w-0">
                        <label for="proposito" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                            Propósito de la unidad curricular
                        </label>
                        <textarea id="proposito" wire:model.defer="proposito" rows="3"
                            class="block w-full rounded-md border-gray-300 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                            placeholder="El propósito se cargará automáticamente al seleccionar una unidad, pero puedes editarlo aquí..."></textarea>
                        @error('proposito')
                            <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>
                </div>

                <!-- Sección de Cortes -->


                <!-- Sección de Cortes -->
                <div class="space-y-6">
                    <h2
                        class="text-xl font-bold pb-4 text-gray-800 dark:text-gray-100 border-b border-gray-300 dark:border-gray-600">
                        Definición de Cortes</h2>

                    @foreach ($cortes as $index => $corte)
                        @php
                            $totalPonderacion = $this->getTotalPonderacionForCorte($index);
                            $validPonderacion = abs($totalPonderacion - 25) < 0.01;
                        @endphp

                        <div
                            class="rounded-lg p-6 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-600 mb-8 shadow-sm">
                            <!-- Cabecera del Corte -->
                            <div
                                class="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-6 gap-2 pb-4 border-b border-gray-300 dark:border-gray-600">
                                <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                                    Corte {{ $corte['numero'] }}
                                </h3>
                                @if (!$validPonderacion)
                                    <span class="text-red-500 text-xs font-medium">La suma debe ser 25%</span>
                                @endif
                            </div>

                            <div class="mb-6">
                                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                    <h4 class="font-medium text-gray-800 dark:text-gray-100">Contenidos</h4>
                                    <button type="button" wire:click="addItem({{ $index }}, 'contenidos')"
                                        class="text-xs bg-blue-500 text-white px-2 py-1 rounded self-start sm:self-auto">
                                        AÑADIR CONTENIDO
                                    </button>
                                </div>

                                @foreach ($corte['contenidos'] as $contenidoIndex => $contenido)
                                    <div class="space-y-4 mb-6">
                                        {{-- Contenido y Indicadores en columnas responsivas --}}
                                        <div class="grid grid-cols-1 xl:grid-cols-2 gap-4">
                                            {{-- Columna de Contenido --}}
                                            <div class="min-w-0">
                                                <div
                                                    class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                                    <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">
                                                        Contenido</h5>
                                                    @if (count($corte['contenidos']) > 1)
                                                        <button type="button"
                                                            wire:click="removeItem({{ $index }}, 'contenidos', {{ $contenidoIndex }})"
                                                            class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto">
                                                            <i class="fas fa-times"></i> ELIMINAR CONTENIDO
                                                        </button>
                                                    @endif
                                                </div>
                                                <x-select :options="$contenidosUnidad" valueField="id_contenido"
                                                    textField="titulo_contenido"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.contenidos.{{ $contenidoIndex }}.contenido_id"
                                                    placeholder="Seleccione un contenido" class="text-sm w-full" />
                                                @error("cortes.$index.contenidos.$contenidoIndex.contenido_id")
                                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                @enderror
                                            </div>

                                            {{-- Columna de Indicadores de Logro --}}
                                            <div class="min-w-0">
                                                <div
                                                    class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                                    <h5 class="font-medium text-gray-700 dark:text-gray-200 text-sm">
                                                        Indicadores de Logro</h5>
                                                    <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                                        <button type="button"
                                                            wire:click="addItem({{ $index }}, 'indicadores_logros', {{ $contenidoIndex }})"
                                                            class="text-xs bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600">
                                                            + AÑADIR INDICADOR
                                                        </button>
                                                        <button type="button" x-data
                                                            x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'indicador' } })"
                                                            class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                                            + NUEVO INDICADOR
                                                        </button>
                                                    </div>
                                                </div>

                                                @forelse ($contenido['indicadores_logros'] as $indicadorIndex => $indicador)
                                                    <div class="flex flex-col sm:flex-row gap-2 mb-2 items-start">
                                                        <div class="flex-grow min-w-0">
                                                            <x-select :options="$indicadores" valueField="id_indicador_logro"
                                                                textField="nombre_indicador_logro"
                                                                wire:model.live.debounce.250ms="cortes.{{ $index }}.contenidos.{{ $contenidoIndex }}.indicadores_logros.{{ $indicadorIndex }}.indicador_id"
                                                                placeholder="Seleccione un indicador" class="text-sm w-full" />
                                                        </div>
                                                        @if (count($contenido['indicadores_logros']) > 1)
                                                            <button type="button"
                                                                wire:click="removeItem({{ $index }}, 'indicadores_logros', {{ $indicadorIndex }}, {{ $contenidoIndex }})"
                                                                class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto">
                                                                <i class="fas fa-times"></i> ELIMINAR INDICADOR
                                                            </button>
                                                        @endif
                                                    </div>
                                                    @error("cortes.$index.contenidos.$contenidoIndex.indicadores_logros.$indicadorIndex.indicador_id")
                                                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                    @enderror
                                                @empty
                                                    <p class="text-sm text-gray-500 dark:text-gray-400">No hay indicadores
                                                        de logro añadidos para este contenido.</p>
                                                @endforelse
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
                                        <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                            <button type="button" x-data
                                                x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'recurso' } })"
                                                class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                                + NUEVO RECURSO
                                            </button>
                                            <button type="button" wire:click="addItem({{ $index }}, 'recursos')"
                                                class="text-xs bg-blue-500 text-white px-2 py-1 rounded">
                                                AÑADIR RECURSO
                                            </button>
                                        </div>
                                    </div>

                                    @foreach ($corte['recursos'] as $recursoIndex => $recurso)
                                        <div class="flex flex-col sm:flex-row gap-2 mb-2">
                                            <div class="flex-grow min-w-0">
                                                <x-select :options="$recursosMaestros" valueField="id_recurso"
                                                    textField="nombre_recurso"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.recursos.{{ $recursoIndex }}.recurso_id"
                                                    placeholder="Seleccione un recurso" class="text-sm w-full" />
                                            </div>
                                            @if (count($corte['recursos']) > 1)
                                                <button type="button"
                                                    wire:click="removeItem({{ $index }}, 'recursos', {{ $recursoIndex }})"
                                                    class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto">
                                                    <i class="fas fa-times"></i> ELIMINAR
                                                </button>
                                            @endif
                                        </div>
                                        @error("cortes.$index.recursos.$recursoIndex.recurso_id")
                                            <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                        @enderror
                                    @endforeach
                                </div>

                                <!-- Estrategias -->
                                <div class="min-w-0">
                                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                        <h4 class="font-medium text-gray-800 dark:text-gray-100">Estrategias</h4>
                                        <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                            <button type="button" x-data
                                                x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'estrategia' } })"
                                                class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                                + NUEVA ESTRATEGIA
                                            </button>
                                            <button type="button" wire:click="addItem({{ $index }}, 'estrategias')"
                                                class="text-xs bg-blue-500 text-white px-2 py-1 rounded">
                                                AÑADIR ESTRATEGIA
                                            </button>
                                        </div>
                                    </div>

                                    @foreach ($corte['estrategias'] as $estrategiaIndex => $estrategia)
                                        <div class="flex flex-col sm:flex-row gap-2 mb-2">
                                            <div class="flex-grow min-w-0">
                                                <x-select :options="$estrategiasMaestras" valueField="id_estrategia_pedagogica"
                                                    textField="nombre_estrategia_pedagogica"
                                                    name="cortes.{{ $index }}.estrategias.{{ $estrategiaIndex }}.estrategia_id"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.estrategias.{{ $estrategiaIndex }}.estrategia_id"
                                                    placeholder="Seleccione una estrategia" class="text-sm w-full" />
                                            </div>
                                            @if (count($corte['estrategias']) > 1)
                                                <button type="button"
                                                    wire:click="removeItem({{ $index }}, 'estrategias', {{ $estrategiaIndex }})"
                                                    class="text-red-500 hover:text-red-700 text-xs self-start sm:self-auto">
                                                    <i class="fas fa-times"></i> ELIMINAR
                                                </button>
                                            @endif
                                        </div>
                                        @error("cortes.$index.estrategias.$estrategiaIndex.estrategia_id")
                                            <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                        @enderror
                                    @endforeach
                                </div>
                            </div>

                            <!-- Evaluaciones -->
                            <div>
                                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                    <div class="flex items-center gap-2">
                                        <h4 class="font-medium text-gray-800 dark:text-gray-100">Evaluaciones</h4>
                                        <span
                                            class="text-sm font-normal {{ $validPonderacion ? 'text-green-600' : 'text-red-600' }}">
                                            ({{ $totalPonderacion }}%)
                                        </span>
                                    </div>
                                    <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                        <button type="button" x-data
                                            x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'evaluacion' } })"
                                            class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                            + NUEVA EVALUACIÓN
                                        </button>
                                        <button type="button" x-data
                                            x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'tecnica' } })"
                                            class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                            + NUEVA TÉCNICA
                                        </button>
                                        <button type="button" wire:click="addItem({{ $index }}, 'evaluaciones')"
                                            class="text-xs bg-blue-500 text-white px-2 py-1 rounded">
                                            AÑADIR EVALUACIÓN
                                        </button>
                                    </div>
                                </div>

                                @foreach ($corte['evaluaciones'] as $evaluacionIndex => $evaluacion)
                                    <div class="pt-4 mb-4 space-y-4">
                                        <!-- Fecha y Evaluación -->
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <div class="min-w-0">
                                                <label for="fecha_evaluacion_{{ $index }}_{{ $evaluacionIndex }}"
                                                    class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Fecha
                                                    de Evaluación:</label>
                                                <input type="date" id="fecha_evaluacion_{{ $index }}_{{ $evaluacionIndex }}"
                                                    name="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.fecha_evaluacion"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.fecha_evaluacion"
                                                    class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                                                                                                           dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500
                                                                                                           date-input-dark"
                                                    style="color-scheme: light;">
                                            </div>
                                            <div class="min-w-0">
                                                <x-select label="Evaluacion" :options="$evaluaciones" valueField="id_evaluacion"
                                                    textField="nombre_evaluacion"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.evaluacion_id" />
                                                @error("cortes.$index.evaluaciones.$evaluacionIndex.evaluacion_id")
                                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                @enderror
                                            </div>
                                        </div>

                                        <!-- Ponderación, Técnica y Forma de Participación -->
                                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                            <div class="min-w-0">
                                                <x-input type="number" step="0.5" min="5" max="25" label="Ponderación (%)"
                                                    name="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.ponderacion"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.ponderacion" />
                                            </div>
                                            <div class="min-w-0">
                                                <x-select label="Técnica" :options="$tecnicas" valueField="id_tecnica"
                                                    textField="nombre_tecnica"
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.tecnica_id" />
                                                @error("cortes.$index.evaluaciones.$evaluacionIndex.tecnica_id")
                                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                @enderror
                                            </div>
                                            <div class="min-w-0">
                                                <label class="block text-sm font-medium mb-1 dark:text-gray-100">Forma de
                                                    Participación</label>
                                                <select
                                                    wire:model.live.debounce.250ms="cortes.{{ $index }}.evaluaciones.{{ $evaluacionIndex }}.forma_participacion"
                                                    class="w-full rounded border-gray-300 dark:bg-gray-800 dark:border-gray-900 dark:text-gray-100 text-sm">
                                                    <option value="">Seleccione</option>
                                                    <option value="1">Individual</option>
                                                    <option value="2">En pareja</option>
                                                    <option value="3">Grupal</option>
                                                </select>
                                                @error("cortes.$index.evaluaciones.$evaluacionIndex.forma_participacion")
                                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                                @enderror
                                            </div>
                                        </div>

                                        <!-- Eliminar -->
                                        @if (count($corte['evaluaciones']) > 1)
                                            <div class="flex justify-end">
                                                <button type="button"
                                                    wire:click="removeItem({{ $index }}, 'evaluaciones', {{ $evaluacionIndex }})"
                                                    class="text-red-500 hover:text-red-700 text-sm">
                                                    <i class="fas fa-trash mr-1"></i> ELIMINAR EVALUACIÓN
                                                </button>
                                            </div>
                                        @endif
                                    </div>
                                @endforeach
                            </div>
                        </div>

                        @if (!$loop->last)
                            <!-- Separador entre cortes -->
                            <div class="flex items-center justify-center my-6">
                                <div class="flex-1 border-t border-gray-300 dark:border-gray-600"></div>
                                <div class="px-4 text-gray-500 dark:text-gray-400 text-sm font-medium">Corte
                                    {{ $corte['numero'] + 1 }}
                                </div>
                                <div class="flex-1 border-t border-gray-300 dark:border-gray-600"></div>
                            </div>
                        @endif
                    @endforeach

                    <div class="bg-white dark:bg-gray-800 shadow-md rounded-lg p-6 mb-6">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 gap-2">
                            <h3 class="text-lg font-semibold text-gray-800 dark:text-gray-100">Bibliografía</h3>
                            <div class="flex flex-wrap gap-2 self-start sm:self-auto">
                                <button type="button" x-data
                                    x-on:click="$dispatch('openModal', { component: 'planificacion.create-input', arguments: { type: 'bibliografia' } })"
                                    class="text-xs bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
                                    + NUEVA BIBLIOGRAFÍA
                                </button>
                                <button type="button" wire:click="addItem(null, 'bibliografias')"
                                    class="text-xs bg-blue-500 text-white px-2 py-1 rounded">
                                    AÑADIR BIBLIOGRAFÍA
                                </button>
                            </div>
                        </div>

                        @foreach ($bibliografias as $biblioIndex => $bibliografia)
                            <div class="flex flex-col sm:flex-row sm:items-center gap-4 mb-4">
                                <div class="flex-grow min-w-0">
                                    <x-select label="Seleccionar Bibliografía" :options="$bibliografiasMaestras"
                                        valueField="id_bibliografia" textField="nombre_bibliografia"
                                        wire:model.live.debounce.250ms="bibliografias.{{ $biblioIndex }}.bibliografia_id" />
                                    @error("bibliografias.$biblioIndex.bibliografia_id")
                                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                    @enderror
                                </div>
                                @if (count($bibliografias) > 1)
                                    <button type="button" wire:click="removeItem(null, 'bibliografias', {{ $biblioIndex }})"
                                        class="text-red-500 hover:text-red-700 text-sm self-start sm:self-auto">
                                        <i class="fas fa-trash mr-1"></i> ELIMINAR
                                    </button>
                                @endif
                            </div>
                        @endforeach
                    </div>

                    <!-- Botón de Guardar -->
                    <div class="flex justify-end">
                        <button type="submit"
                            class="inline-flex items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed">
                            <i class="fas fa-save mr-2"></i> GUARDAR PLANIFICACIÓN
                        </button>
                    </div>
                </div>

        </form>
    </div>
</div>