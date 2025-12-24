{{-- resources/views/livewire/planificacion/show-planificacion.blade.php --}}

<div>
    <div class="p-6 bg-white dark:bg-gray-800"> {{-- Contenedor principal con padding y fondo --}}
        <div class="md:grid md:grid-cols-1 md:gap-6"> {{-- Grid para la sección de título y contenido --}}
            <div class="md:col-span-2"> {{-- Columna para el título principal --}}
                <h3 class="text-xl font-semibold leading-tight text-gray-900 dark:text-gray-100">
                    Detalles de la Planificación
                </h3>
                <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                    Información detallada sobre la planificación seleccionada.
                </p>
            </div>

            <div class="mt-5 md:col-span-2 md:mt-0"> {{-- Columna para el contenido principal (la tarjeta grande) --}}
                <div class="shadow sm:rounded-md sm:overflow-hidden dark:bg-gray-800">
                    {{-- Contenedor con scroll interno y padding --}}
                    <div class="px-4 py-5 bg-white sm:p-6 dark:bg-gray-800 max-h-[60vh] overflow-y-auto">

                        @if (!$planificacion)
                            <div class="text-center py-8">
                                <p class="text-red-600 dark:text-red-400 font-semibold">No se pudo cargar la
                                    planificación.
                                </p>
                            </div>
                        @else
                            <div class="space-y-6"> {{-- Contenedor principal para toda la información de la planificación con espaciado vertical --}}
                                <h2
                                    class="text-2xl font-bold leading-tight text-gray-900 dark:text-gray-100 border-b border-gray-200 dark:border-gray-700 pb-2 mb-4 text-center">
                                    Planificación: {{ $planificacion->nombre_unidad_curricular ?? 'N/A' }} -
                                    {{ $planificacion->nombre_seccion ?? 'N/A' }}
                                </h2>

                                {{-- Mensajes de Livewire (éxito o error) --}}
                                @if (session()->has('message'))
                                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative"
                                        role="alert">
                                        <span class="block sm:inline">{{ session('message') }}</span>
                                    </div>
                                @endif
                                @if (session()->has('error'))
                                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
                                        role="alert">
                                        <span class="block sm:inline">{{ session('error') }}</span>
                                    </div>
                                @endif

                                {{-- Sección de Información General de la Planificación --}}
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-2">Detalles
                                        Generales</h4>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4 text-sm">
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Docente:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->docente_nombre ?? '' }}
                                                {{ $planificacion->docente_apellido ?? '' }}</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Cédula:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->cedula ?? 'N/A' }}
                                            </dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Teléfono:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->telefono ?? 'N/A' }}</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Lapso Académico:
                                            </dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->nombre_lapso ?? 'N/A' }}
                                                @if ($planificacion->lapso_fecha_inicio && $planificacion->lapso_fecha_fin)
                                                    ({{ \Carbon\Carbon::parse($planificacion->lapso_fecha_inicio)->format('d/m/Y') }}
                                                    -
                                                    {{ \Carbon\Carbon::parse($planificacion->lapso_fecha_fin)->format('d/m/Y') }})
                                                @endif
                                            </dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Sección:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->nombre_seccion ?? 'N/A' }}</dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Semestre:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                @php

                                                    $semestre = $planificacion->nombre_seccion
                                                        ? substr($planificacion->nombre_seccion, 0, 1)
                                                        : null;
                                                    $semestre = $planificacion->nombre_seccion
                                                        ? substr($planificacion->nombre_seccion, 0, 1)
                                                        : null;

                                                @endphp
                                                {{ $semestre === '0' ? 'Introductorio' : $semestre ?? 'N/A' }}
                                            </dd>
                                        </div>
                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Unidad
                                                Curricular:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                {{ $planificacion->nombre_unidad_curricular ?? 'N/A' }}</dd>
                                        </div>

                                        <div>
                                            <dt class="font-medium text-gray-500 dark:text-gray-400">Estatus:</dt>
                                            <dd class="mt-1 text-gray-900 dark:text-gray-100">
                                                @php
                                                    // Usamos el $estatusTexto que ya viene mapeado desde el componente
                                                    $estatusClass = '';
                                                    switch ($planificacion->estatus) {
                                                        case 1:
                                                            $estatusClass =
                                                                'text-green-700 bg-green-100 dark:bg-green-600 dark:text-green-100';
                                                            break;
                                                        case 2:
                                                            $estatusClass =
                                                                'text-yellow-700 bg-yellow-100 dark:bg-yellow-600 dark:text-yellow-100';
                                                            break;
                                                        case 3:
                                                            $estatusClass =
                                                                'text-red-700 bg-red-100 dark:bg-red-600 dark:text-red-100';
                                                            break;
                                                        default:
                                                            $estatusClass =
                                                                'text-gray-700 bg-gray-100 dark:bg-gray-600 dark:text-gray-100';
                                                            break;
                                                    }
                                                @endphp
                                                <span
                                                    class="px-2 py-1 font-semibold leading-tight rounded-full {{ $estatusClass }}">
                                                    {{ $estatusTexto ?? 'Desconocido' }}
                                                </span>
                                            </dd>
                                        </div>

                                    </div>
                                </div>

                                <hr class="border-gray-200 dark:border-gray-700"> {{-- Separador visual --}}

                                {{-- Cortes de la Planificación --}}
                                <div>
                                    <h3 class="text-xl font-bold leading-tight text-gray-900 dark:text-gray-100 mb-3">
                                        Cortes:</h3>
                                    @if (empty($planificacion->cortes))
                                        <p class="text-gray-500 dark:text-gray-400">No hay cortes definidos para esta
                                            planificación.</p>
                                    @else
                                        <div class="space-y-4"> {{-- Espacio entre cada tarjeta de corte --}}
                                            @foreach ($planificacion->cortes as $corte)
                                                <div
                                                    class="border border-gray-200 dark:border-gray-700 p-4 rounded-lg shadow-sm bg-gray-50 dark:bg-gray-700">
                                                    <h4
                                                        class="text-lg font-semibold text-indigo-700 dark:text-indigo-300 mb-2">
                                                        Corte {{ $corte->corte }}
                                                        - Estatus:
                                                        @php
                                                            $corteEstatusClass = '';
                                                            switch ($corte->estatus) {
                                                                case 1:
                                                                    $corteEstatusClass =
                                                                        'text-green-700 bg-green-100 dark:bg-green-600 dark:text-green-100';
                                                                    break;
                                                                case 2:
                                                                    $corteEstatusClass =
                                                                        'text-yellow-700 bg-yellow-100 dark:bg-yellow-600 dark:text-yellow-100';
                                                                    break;
                                                                case 3:
                                                                    $corteEstatusClass =
                                                                        'text-red-700 bg-red-100 dark:bg-red-600 dark:text-red-100';
                                                                    break;
                                                                default:
                                                                    $corteEstatusClass =
                                                                        'text-gray-700 bg-gray-100 dark:bg-gray-600 dark:text-gray-100';
                                                                    break;
                                                            }
                                                        @endphp
                                                        <span
                                                            class="px-2 py-1 text-sm font-semibold leading-tight rounded-full {{ $corteEstatusClass }}">
                                                            {{ $corte->estatus_texto ?? 'N/A' }}
                                                        </span>
                                                    </h4>

                                                    {{-- Campo para el motivo de rechazo por corte --}}
                                                    @can('is-coordinador')
                                                        @if (($corte->estatus ?? null) == 3 && !empty($corte->ultimo_motivo_rechazo))
                                                            <div class="flex items-center mt-2">
                                                                <span class="text-xs text-red-500 mr-2">Último motivo:
                                                                    {{ $corte->ultimo_motivo_rechazo }}</span>
                                                            </div>
                                                        @else
                                                            @if (empty($motivosRechazoCortes[$corte->detalle_id]) &&
                                                                    empty($mostrarMotivoRechazoCorte[$corte->detalle_id]) &&
                                                                    ($planificacion->estatus ?? null) != 1)
                                                                <div class="mt-3 mb-4">
                                                                    <button type="button"
                                                                        wire:click="mostrarTextareaMotivo({{ $corte->detalle_id }})"
                                                                        class="text-xs text-red-600 border border-red-600 px-2 py-1 rounded hover:bg-red-50">Rechazar
                                                                        este corte</button>
                                                                </div>
                                                            @endif
                                                            @if (!empty($mostrarMotivoRechazoCorte[$corte->detalle_id]))
                                                                <label for="motivoRechazoCorte_{{ $corte->detalle_id }}"
                                                                    class="block text-sm font-medium text-gray-800 dark:text-gray-100 mt-2">
                                                                    Motivo de rechazo para este corte:
                                                                </label>
                                                                <div class="flex items-start gap-2">
                                                                    <textarea id="motivoRechazoCorte_{{ $corte->detalle_id }}"
                                                                        wire:model.defer="motivosRechazoCortes.{{ $corte->detalle_id }}" rows="3"
                                                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600 dark:text-gray-100"
                                                                        placeholder="Ingrese el motivo de rechazo si este corte debe ser rechazado..." autofocus="false" tabindex="-1"></textarea>
                                                                    <button type="button"
                                                                        wire:click="ocultarTextareaMotivo({{ $corte->detalle_id }})"
                                                                        class="ml-2 text-xs text-gray-500 border border-gray-300 rounded px-2 py-1 hover:bg-gray-100">Cancelar</button>
                                                                </div>
                                                                @error('motivosRechazoCortes.' . $corte->detalle_id)
                                                                    <p class="mt-1 text-xs text-red-600">{{ $message }}
                                                                    </p>
                                                                @enderror
                                                            @endif
                                                        @endif
                                                    @endcan

                                                    {{-- Contenidos e Indicadores --}}
                                                    <div
                                                        class="mt-3 grid grid-cols-1 md:grid-cols-2 gap-4 border-b border-gray-300 dark:border-gray-600 pb-2 mb-2">
                                                        <div>
                                                            <dt
                                                                class="text-sm font-medium text-gray-800 dark:text-gray-100">
                                                                Contenidos:</dt>
                                                            @if (!empty($corte->contenidos))
                                                                <div class="space-y-2">
                                                                    {{-- Espacio entre cada contenido --}}
                                                                    @foreach ($corte->contenidos as $contenido)
                                                                        <div class="">
                                                                            <p
                                                                                class="font-semibold text-gray-900 dark:text-gray-100">
                                                                                {{ $contenido['titulo_contenido'] ?? 'N/A' }}:
                                                                            </p>
                                                                            <p
                                                                                class="text-xs text-gray-500 dark:text-gray-100">
                                                                                {{ $contenido['descripcion_contenido'] ?? 'Sin descripción' }}
                                                                            </p>
                                                                        </div>
                                                                    @endforeach
                                                                </div>
                                                            @else
                                                                <dd
                                                                    class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                                                                    (Sin contenidos)
                                                                </dd>
                                                            @endif
                                                        </div>

                                                        <div>
                                                            <dt
                                                                class="text-sm font-medium text-gray-800 dark:text-gray-100">
                                                                Indicadores de Logros:</dt>
                                                            @if (!empty($corte->contenidos))
                                                                <div class="space-y-2">
                                                                    {{-- Espacio entre cada indicador --}}
                                                                    @foreach ($corte->contenidos as $contenido)
                                                                        @if (!empty($contenido['indicadores_logros']))
                                                                            <ul
                                                                                class="list-disc list-inside text-xs pl-4 mt-1 text-gray-800 dark:text-gray-200">
                                                                                @foreach ($contenido['indicadores_logros'] as $indicador)
                                                                                    <li>
                                                                                        {{ $indicador['descripcion_indicador'] ?? 'N/A' }}
                                                                                    </li>
                                                                                @endforeach
                                                                            </ul>
                                                                        @else
                                                                            <p
                                                                                class="text-xs text-gray-500 dark:text-gray-400">
                                                                                (Sin indicadores de logros)
                                                                            </p>
                                                                        @endif
                                                                    @endforeach
                                                                </div>
                                                            @else
                                                                <dd
                                                                    class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                                                                    (Sin indicadores)</dd>
                                                            @endif
                                                        </div>
                                                    </div>

                                                    {{-- Recursos y Estrategias --}}
                                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-3">
                                                        <div>
                                                            <dt
                                                                class="text-sm font-medium text-gray-800 dark:text-gray-100">
                                                                Recursos:</dt>
                                                            @if (!empty($corte->recursos))
                                                                <ul
                                                                    class="list-disc list-inside text-sm pl-4 mt-1 text-gray-800 dark:text-gray-100">
                                                                    @foreach ($corte->recursos as $recurso)
                                                                        <li>{{ $recurso['recurso'] ?? 'N/A' }}</li>
                                                                    @endforeach
                                                                </ul>
                                                            @else
                                                                <dd
                                                                    class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                                                                    (Sin recursos)
                                                                </dd>
                                                            @endif
                                                        </div>

                                                        <div>
                                                            <dt
                                                                class="text-sm font-medium text-gray-800 dark:text-gray-100">
                                                                Estrategias Pedagógicas:</dt>
                                                            @if (!empty($corte->estrategias))
                                                                <ul
                                                                    class="list-disc list-inside text-sm pl-4 mt-1 text-gray-800 dark:text-gray-100">
                                                                    @foreach ($corte->estrategias as $estrategia)
                                                                        <li>{{ $estrategia['estrategia'] ?? 'N/A' }}
                                                                        </li>
                                                                    @endforeach
                                                                </ul>
                                                            @else
                                                                <dd
                                                                    class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                                                                    (Sin estrategias)</dd>
                                                            @endif
                                                        </div>
                                                    </div>

                                                    {{-- Evaluaciones --}}
                                                    <div class="mt-3">
                                                        <dt
                                                            class="text-sm font-medium text-gray-800 dark:text-gray-100 mb-1">
                                                            Evaluaciones:</dt>
                                                        @if (!empty($corte->evaluaciones))
                                                            <div class="overflow-x-auto">
                                                                <table
                                                                    class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 border border-gray-200 dark:border-gray-700 rounded-lg">
                                                                    <thead class="bg-gray-100 dark:bg-gray-600">
                                                                        <tr>
                                                                            <th
                                                                                class="px-3 py-2 text-left text-xs font-medium text-gray-600 uppercase tracking-wider dark:text-gray-300">
                                                                                Evaluación</th>
                                                                            <th
                                                                                class="px-3 py-2 text-left text-xs font-medium text-gray-600 uppercase tracking-wider dark:text-gray-300">
                                                                                Técnica</th>
                                                                            <th
                                                                                class="px-3 py-2 text-left text-xs font-medium text-gray-600 uppercase tracking-wider dark:text-gray-300">
                                                                                Ponderación (%)</th>
                                                                            <th
                                                                                class="px-3 py-2 text-left text-xs font-medium text-gray-600 uppercase tracking-wider dark:text-gray-300">
                                                                                Fecha</th>
                                                                            <th
                                                                                class="px-3 py-2 text-left text-xs font-medium text-gray-600 uppercase tracking-wider dark:text-gray-300">
                                                                                Forma de Participación</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody
                                                                        class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">
                                                                        @foreach ($corte->evaluaciones as $evaluacion)
                                                                            <tr>
                                                                                <td
                                                                                    class="px-3 py-2 text-sm text-gray-900 dark:text-gray-100">
                                                                                    {{ $evaluacion['evaluacion'] ?? 'N/A' }}
                                                                                </td>
                                                                                <td
                                                                                    class="px-3 py-2 text-sm text-gray-900 dark:text-gray-100">
                                                                                    {{ $evaluacion['tecnica'] ?? 'N/A' }}
                                                                                </td>
                                                                                <td
                                                                                    class="px-3 py-2 text-sm text-gray-900 dark:text-gray-100">
                                                                                    {{ $evaluacion['ponderacion'] ?? 'N/A' }}
                                                                                </td>
                                                                                <td
                                                                                    class="px-3 py-2 text-sm text-gray-900 dark:text-gray-100">
                                                                                    {{ \Carbon\Carbon::parse($evaluacion['fecha_evaluacion'])->format('d/m/Y') }}
                                                                                </td>
                                                                                <td
                                                                                    class="px-3 py-2 text-sm text-gray-900 dark:text-gray-100">
                                                                                    @switch($evaluacion['forma_participacion'])
                                                                                        @case(1)
                                                                                            Individual
                                                                                        @break

                                                                                        @case(2)
                                                                                            En pareja
                                                                                        @break

                                                                                        @case(3)
                                                                                            Grupal
                                                                                        @break

                                                                                        @default
                                                                                            Desconocido
                                                                                        @break
                                                                                    @endswitch
                                                                                </td>
                                                                            </tr>
                                                                        @endforeach
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        @else
                                                            <dd class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                                                                (Sin evaluaciones)</dd>
                                                        @endif
                                                    </div>
                                                    {{-- **NUEVO: Motivo de Rechazo para este Corte** --}}
                                                    @if (($corte->estatus ?? null) == 3 && !empty($corte->motivo_rechazo))
                                                        <div
                                                            class="mt-4 p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-700 rounded-md">
                                                            <p
                                                                class="text-sm font-medium text-red-800 dark:text-red-300">
                                                                Motivo de Rechazo: <span
                                                                    class="font-normal">{{ $corte->motivo_rechazo }}</span>
                                                            </p>
                                                        </div>
                                                    @endif
                                                </div>
                                            @endforeach
                                        </div>
                                    @endif
                                </div>

                                <hr class="border-gray-200 dark:border-gray-700"> {{-- Separador visual --}}

                                {{-- Bibliografías --}}
                                <div>
                                    <h3 class="text-xl font-bold leading-tight text-gray-900 dark:text-gray-100 mb-3">
                                        Bibliografías:</h3>
                                    @if (empty($planificacion->bibliografias))
                                        <p class="text-gray-500 dark:text-gray-400">No hay bibliografías asociadas a
                                            esta
                                            planificación.</p>
                                    @else
                                        <ul
                                            class="list-disc list-inside text-sm pl-4 space-y-1 text-gray-800 dark:text-gray-100">
                                            @foreach ($planificacion->bibliografias as $bibliografia)
                                                <li>{{ $bibliografia['bibliografia'] ?? 'N/A' }}</li>
                                            @endforeach
                                        </ul>
                                    @endif
                                </div>
                            </div> {{-- Cierre de space-y-6 --}}
                        @endif
                    </div>
                </div>
            </div>
        </div>

        {{-- Botones de acción para la planificación completa, solo visibles para coordinadores --}}
        {{-- Mueve este bloque aquí para que esté dentro del p-6 y antes del botón de cerrar global del modal --}}
        @can('is-coordinador')
            <div
                class="px-4 py-3 bg-gray-50 text-right sm:px-6 dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700 flex justify-end items-center">
                {{-- Botón Aprobar Planificación --}}
                @if (($planificacion->estatus ?? null) == 2 || ($planificacion->estatus ?? null) == 3)
                    <button wire:click="aprobarPlanificacion" wire:loading.attr="disabled"
                        wire:target="aprobarPlanificacion"
                        class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 me-2 disabled:opacity-50 disabled:cursor-not-allowed">
                        <span wire:loading.remove wire:target="aprobarPlanificacion">Aprobar Planificación</span>
                        <span wire:loading wire:target="aprobarPlanificacion">Aprobando...</span>
                    </button>
                @endif

                {{-- Botón "Rechazar Planificación" global --}}
                @if ($mostrarBotonRechazarPlanificacion)
                    <div class="">
                        <button wire:click="rechazarPlanificacion" wire:loading.attr="disabled"
                            wire:target="rechazarPlanificacion"
                            class="bg-red-600 text-white px-4 py-2 rounded disabled:opacity-50">
                            <span wire:loading.remove wire:target="rechazarPlanificacion">Rechazar Planificación</span>
                            <span wire:loading wire:target="rechazarPlanificacion">Rechazando...</span>
                        </button>
                    </div>
                @else
                    {{-- Si la planificación ya está aprobada, mostrar un mensaje informativo --}}
                    @if (($planificacion->estatus ?? null) == 1)
                        <p class="text-sm text-gray-500 dark:text-gray-400 ms-3 my-auto">Esta planificación ha sido
                            aprobada y no puede ser rechazada.</p>
                    @endif
                @endif
            </div>
        @else
            <div
                class="px-4 py-3 bg-gray-50 text-center sm:px-6 dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
                <p class="text-sm text-gray-500 dark:text-gray-400">Solo los coordinadores pueden aprobar o rechazar esta
                    planificación.</p>
            </div>
        @endcan

    </div>

    {{-- Botón de Cerrar (Mantengo tu estructura original para este botón) --}}
    <div
        class="px-4 py-3 bg-gray-50 text-right sm:px-6 dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
        <button type="button" wire:click="$dispatch('closeModal')"
            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            Cerrar
        </button>

    </div>

</div>
