<div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold mb-4 text-gray-800 dark:text-gray-200">Listado de Planificaciones de
        {{ $docente }}</h2>

    <div class="overflow-x-auto shadow-md sm:rounded-lg">
        <!-- Filtros -->
        <div class="mb-4 grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 items-end mt-4">
            <div>
                <label for="filterLapsoAcademico"
                    class="block text-xs font-medium text-gray-700 dark:text-gray-300">Filtrar
                    por Lapso:</label>
                <select wire:model.live="filterLapsoId" id="filterLapsoAcademico"
                    class="block w-full py-2 px-3 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm text-gray-900 dark:text-gray-100">
                    <option value="">Todos los Lapsos</option>
                    @foreach ($lapsosFiltrados as $lapso)
                        <option value="{{ $lapso->lapso_id }}">{{ $lapso->lapso }}</option>
                    @endforeach
                </select>
            </div>

            <div>
                <label for="filterSeccion" class="block text-xs font-medium text-gray-700 dark:text-gray-300">Filtrar
                    por Sección:</label>
                <select wire:model.live="filterSeccionId" id="filterSeccion"
                    class="block w-full py-2 px-3 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm text-gray-900 dark:text-gray-100"
                    @if (!$filterLapsoId || count($seccionesFiltradas) === 0) disabled @endif>
                    @if (!$filterLapsoId)
                        <option value="">Seleccione un lapso primero</option>
                    @elseif(count($seccionesFiltradas) === 0)
                        <option value="">No hay secciones para este lapso</option>
                    @else
                        <option value="">Todas las Secciones</option>
                        @foreach ($seccionesFiltradas as $seccion)
                            <option value="{{ $seccion->seccion_id }}">{{ $seccion->seccion }}</option>
                        @endforeach
                    @endif
                </select>
            </div>

            <div>
                <label for="filterUnidadCurricular"
                    class="block text-xs font-medium text-gray-700 dark:text-gray-300">Filtrar por Unidad
                    Curricular:</label>
                <select wire:model.live="filterUnidadCurricularCodigo" id="filterUnidadCurricular"
                    class="block w-full py-2 px-3 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm text-gray-900 dark:text-gray-100">
                    <option value="">Todas las Unidades</option>
                    @foreach ($unidadesCurriculares as $unidad)
                        <option value="{{ $unidad->codigo }}">{{ $unidad->nombre }}</option>
                    @endforeach
                </select>
            </div>
        </div>

        <!-- Tabla para pantallas grandes -->
        <div class="hidden sm:block">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 table-fixed">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-3 py-3">Docente</th>
                        <th scope="col" class="px-3 py-3">Sección</th>
                        <th scope="col" class="px-3 py-3">Unidad Curricular</th>
                        <th scope="col" class="px-3 py-3">Lapso Académico</th>
                        <th scope="col" class="px-3 py-3 text-left">Estatus</th>
                        <th scope="col" class="px-3 py-3 text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @if ($planificaciones->isNotEmpty())
                        @foreach ($planificaciones as $planificacion)
                            <tr wire:key="{{ $planificacion->planificacion_id }}"
                                class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                <td class="px-3 py-4 font-medium text-gray-900 dark:text-white">
                                    {{ $planificacion->docente_nombre }} {{ $planificacion->docente_apellido }}
                                </td>
                                <td class="px-3 py-4 font-medium text-gray-900 dark:text-white">
                                    {{ $planificacion->seccion }}
                                </td>
                                <td class="px-3 py-4 font-medium text-gray-900 dark:text-white">
                                    {{ $planificacion->unidad_curricular }}
                                </td>
                                <td class="px-3 py-4 font-medium text-gray-900 dark:text-white">
                                    {{ $planificacion->lapso }}
                                </td>
                                <td class="px-3 py-4 text-left">
                                    @if ($planificacion->estatus == 1)
                                        <span class="border-2 border-green-500 rounded-md px-2 py-1 dark:text-gray-300">
                                            Aprobada
                                        </span>
                                    @elseif($planificacion->estatus == 2)
                                        <span
                                            class="border-2 border-yellow-500 rounded-md px-2 py-1 dark:text-gray-300">
                                            Pendiente
                                        </span>
                                    @elseif($planificacion->estatus == 3)
                                        <span class="border-2 border-red-500 rounded-md px-2 py-1 dark:text-gray-300">
                                            Rechazada
                                        </span>
                                    @else
                                        <span class="border-2 border-gray-500 rounded-md px-2 py-1 dark:text-gray-300">
                                            Desconocido
                                        </span>
                                    @endif
                                </td>
                                <td class="px-3 py-4 text-right">
                                    <button x-data
                                        x-on:click="$dispatch('openModal', { component: 'planificacion.show-planificacion', arguments: { planificacionId: '{{ $planificacion->planificacion_id }}' } })"
                                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-2 rounded">Ver</button>
                                    @if ($planificacion->estatus == 3)
                                        <a href="{{ route('planificaciones.update', $planificacion->planificacion_id) }}"
                                            class="ml-2 bg-yellow-500 hover:bg-yellow-600 text-white font-bold py-2 px-2 rounded">Editar</a>
                                    @endif
                                    @if ($planificacion->estatus == 1)
                                        <button wire:click="exportarPdf({{ $planificacion->planificacion_id }})"
                                            class="ml-2 bg-green-600 hover:bg-green-700 text-white font-bold py-2 px-2 rounded flex items-center gap-1"
                                            title="Descargar PDF">
                                            <span class="material-icons text-white text-lg">picture_as_pdf</span>
                                            PDF
                                        </button>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @else
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <td colspan="6" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                                No hay planificaciones registradas.
                            </td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>

        <!-- Versión móvil -->
        <div class="sm:hidden">
            @if ($planificaciones->isNotEmpty())
                @foreach ($planificaciones as $planificacion)
                    <div wire:key="{{ $planificacion->planificacion_id }}"
                        class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 py-4 px-3">
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Docente:</span>
                            <span class="text-gray-900 dark:text-gray-100">
                                {{ $planificacion->docente_nombre }} {{ $planificacion->docente_apellido }}
                            </span>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Sección:</span>
                            <span class="text-gray-900 dark:text-gray-100">{{ $planificacion->seccion }}</span>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Unidad Curricular:</span>
                            <span
                                class="text-gray-900 dark:text-gray-100">{{ $planificacion->unidad_curricular }}</span>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Lapso:</span>
                            <span class="text-gray-900 dark:text-gray-100">{{ $planificacion->lapso }}</span>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Estatus:</span>
                            @if ($planificacion->estatus == 1)
                                <span class="border-2 border-green-500 rounded-md px-2 py-1 dark:text-gray-300">
                                    Aprobada
                                </span>
                            @elseif($planificacion->estatus == 2)
                                <span class="border-2 border-yellow-500 rounded-md px-2 py-1 dark:text-gray-300">
                                    Pendiente
                                </span>
                            @elseif($planificacion->estatus == 3)
                                <span class="border-2 border-red-500 rounded-md px-2 py-1 dark:text-gray-300">
                                    Rechazada
                                </span>
                            @else
                                <span class="border-2 border-gray-500 rounded-md px-2 py-1 dark:text-gray-300">
                                    Desconocido
                                </span>
                            @endif
                        </div>
                        <div class="flex space-x-2 justify-end">
                            <button x-data
                                x-on:click="$dispatch('openModal', { component: 'planificacion.show-planificacion', arguments: { planificacionId: '{{ $planificacion->planificacion_id }}' } })"
                                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-2 rounded">Ver</button>
                            @if ($planificacion->estatus == 3)
                                <a href="{{ route('planificaciones.update', $planificacion->planificacion_id) }}"
                                    class="bg-yellow-500 hover:bg-yellow-600 text-white font-bold py-2 px-2 rounded">Editar</a>
                            @endif
                            @if ($planificacion->estatus == 1)
                                <button wire:click="exportarPdf({{ $planificacion->planificacion_id }})"
                                    class="bg-green-600 hover:bg-green-700 text-white font-bold py-2 px-2 rounded flex items-center gap-1"
                                    title="Descargar PDF">
                                    <span class="material-icons text-white text-lg">picture_as_pdf</span>
                                    PDF
                                </button>
                            @endif
                        </div>
                    </div>
                @endforeach
            @else
                <div
                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 py-4 px-3 text-center text-gray-500 dark:text-gray-400">
                    No hay planificaciones registradas.
                </div>
            @endif
        </div>
    </div>

    <!-- Paginación -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 py-3 px-4 overflow-x-auto">
        <div class="order-1 sm:order-1 flex items-center space-x-2 flex-shrink-0">
            <label for="perPage" class="text-sm font-medium text-gray-700 dark:text-gray-300">Mostrar:</label>
            <select id="perPage" wire:model.live="perPage"
                class="block w-20 py-2 px-3 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm text-gray-900 dark:text-gray-100">
                <option value="5">5</option>
                <option value="10">10</option>
                <option value="25">25</option>
                <option value="50">50</option>
            </select>
            <span class="text-sm font-medium text-gray-700 dark:text-gray-300">por página</span>
        </div>
        <div class="order-2 sm:order-2 flex-grow w-full sm:w-auto">
            @if ($planificaciones->hasPages())
                {{ $planificaciones->links() }}
            @endif
        </div>
    </div>


</div>
