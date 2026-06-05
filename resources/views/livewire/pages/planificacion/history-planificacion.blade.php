<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Historial de Planificaciones') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 sm:rounded-lg">
            <x-table.alert-message />
        </div>
    </div>

    <div class="sogat-table-container">
        <!-- Controles -->
        <div class="flex flex-col space-y-3 sm:flex-row sm:space-y-0 sm:items-center sm:justify-between p-4 bg-white dark:bg-gray-800">
            <!-- Búsqueda -->
            <input type="text" wire:model.live.debounce.300ms="search"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white"
                placeholder="Buscar en el historial...">
        </div>

        <!-- Tabla -->
        <div class="hidden sm:block">
            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Lapso Académico</th>
                        <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">U. Curricular / Sección</th>
                        <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Trayecto / Semestre</th>
                        <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">Estatus</th>
                        <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @if ($planificaciones->isNotEmpty())
                        @foreach ($planificaciones as $planificacion)
                            <tr wire:key="hist-{{ $planificacion->planificacion_id }}"
                                class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                <!-- Lapso Académico -->
                                <td class="px-4 py-4 text-gray-900 dark:text-white font-semibold">
                                    {{ $planificacion->nombre_lapso }}
                                </td>
                                <!-- U. Curricular / Sección -->
                                <td class="px-4 py-4 text-gray-900 dark:text-white">
                                    <div class="font-semibold">{{ $planificacion->nombre_unidad_curricular }}</div>
                                    <div class="text-xs text-gray-500">Sección: {{ $planificacion->nombre_seccion }}</div>
                                </td>
                                <!-- Trayecto / Semestre -->
                                <td class="px-4 py-4 text-gray-900 dark:text-white">
                                    <div class="font-semibold">{{ $planificacion->nombre_trayecto ?? 'N/A' }}</div>
                                    <div class="text-xs text-gray-500">{{ $planificacion->nombre_semestre ?? 'N/A' }}</div>
                                </td>
                                <!-- Estatus -->
                                <td class="px-4 py-4 text-right">
                                    @if ($planificacion->estatus == 1)
                                        <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">Aprobada</span>
                                    @elseif($planificacion->estatus == 2)
                                        <span class="bg-blue-100 text-blue-600 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-200">Pendiente</span>
                                    @elseif($planificacion->estatus == 3)
                                        <span class="bg-red-100 text-red-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300">Rechazada</span>
                                    @elseif($planificacion->estatus == 4)
                                        <span class="bg-amber-100 text-amber-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-amber-900 dark:text-amber-300">Borrador</span>
                                    @else
                                        <span class="bg-gray-100 text-gray-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-gray-900 dark:text-gray-300">Desconocido</span>
                                    @endif
                                </td>
                                <!-- Acciones -->
                                <td class="px-4 py-4">
                                    <div class="flex items-center justify-end space-x-2">
                                        <button wire:click="selectPlanificacionParaDuplicar({{ $planificacion->planificacion_id }})"
                                            class="flex items-center gap-1 bg-blue-600 text-white text-xs font-medium px-2.5 py-1 rounded-md hover:bg-blue-700 dark:bg-blue-600 dark:hover:bg-blue-700 shadow-sm transition-colors">
                                            <span class="material-icons" style="font-size: 16px;">content_copy</span>
                                            {{ __('Importar') }}
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                    @else
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <td colspan="5" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                                No se encontraron planificaciones anteriores en su historial.
                            </td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>

        <!-- Vista lista en pantallas xs -->
        <div class="sm:hidden">
            @if ($planificaciones->isNotEmpty())
                @foreach ($planificaciones as $planificacion)
                    <div wire:key="hist-xs-{{ $planificacion->planificacion_id }}"
                        class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 py-4 px-3 hover:bg-gray-50 dark:hover:bg-gray-600">
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Lapso Académico:</span>
                            <span class="text-gray-900 dark:text-white font-semibold">{{ $planificacion->nombre_lapso }}</span>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">U.C. / Sección:</span>
                            <div class="text-gray-900 dark:text-white">
                                {{ $planificacion->nombre_unidad_curricular }} ({{ $planificacion->nombre_seccion }})
                            </div>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Trayecto / Semestre:</span>
                            <div class="text-gray-900 dark:text-white">
                                {{ $planificacion->nombre_trayecto ?? 'N/A' }} - {{ $planificacion->nombre_semestre ?? 'N/A' }}
                            </div>
                        </div>
                        <div class="mb-2">
                            <span class="font-semibold text-gray-700 dark:text-gray-300">Estado:</span>
                            @if ($planificacion->estatus == 1)
                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">Aprobada</span>
                            @elseif($planificacion->estatus == 2)
                                <span class="bg-blue-100 text-blue-600 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-200">Pendiente</span>
                            @elseif($planificacion->estatus == 3)
                                <span class="bg-red-100 text-red-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300">Rechazada</span>
                            @elseif($planificacion->estatus == 4)
                                <span class="bg-amber-100 text-amber-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-amber-900 dark:text-amber-300">Borrador</span>
                            @endif
                        </div>
                        <div class="flex justify-end mt-3">
                            <button wire:click="selectPlanificacionParaDuplicar({{ $planificacion->planificacion_id }})"
                                class="flex items-center gap-1 bg-blue-600 text-white text-xs font-medium px-2.5 py-1 rounded-md hover:bg-blue-700 dark:bg-blue-600 dark:hover:bg-blue-700 shadow-sm transition-colors">
                                <span class="material-icons" style="font-size: 16px;">content_copy</span>
                                {{ __('Importar') }}
                            </button>
                        </div>
                    </div>
                @endforeach
            @else
                <div class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 py-4 px-3 text-center text-gray-500 dark:text-gray-400">
                    No se encontraron planificaciones anteriores en su historial.
                </div>
            @endif
        </div>

        <!-- Paginación -->
        <div class="flex flex-col md:flex-row items-center justify-between p-4 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
            <div class="flex items-center mb-4 md:mb-0">
                <select id="perPage" wire:model.live="perPage"
                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white w-24">
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="20">20</option>
                </select>
            </div>
            <div>{{ $planificaciones->links() }}</div>
        </div>
    </div>
    <!-- Modal Premium para Duplicación -->
    @if($showDuplicarModal)
        <div class="fixed inset-0 overflow-y-auto z-50 flex items-center justify-center p-4">
            <div class="fixed inset-0 bg-gray-500 dark:bg-gray-900 opacity-75 transition-opacity" wire:click="closeDuplicarModal"></div>
            
            <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-2xl overflow-hidden transform transition-all max-w-3xl w-full border border-gray-200 dark:border-gray-700 relative z-10">
                <!-- Modal Header -->
                <div class="px-6 py-4 bg-gray-50 dark:bg-gray-700 border-b border-gray-200 dark:border-gray-600 flex justify-between items-center">
                    <h3 class="text-lg font-bold text-gray-900 dark:text-white uppercase flex items-center gap-2">
                        <span class="material-icons text-sogat-blue dark:text-blue-400">content_copy</span>
                        {{ __('Importar Planificación') }}
                    </h3>
                    <button type="button" wire:click="closeDuplicarModal" class="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                        <span class="material-icons">close</span>
                    </button>
                </div>

                <form wire:submit.prevent="duplicar" class="p-6 space-y-6 max-h-[75vh] overflow-y-auto">
                    <!-- Sección de Destino -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Asignatura de Destino -->
                        <div class="w-full">
                            <label for="destino_asignacion" class="block font-bold text-sm text-gray-900 dark:text-white uppercase mb-1">
                                {{ __('Asignación de Destino (Lapso Actual)') }}
                            </label>
                            <x-select id="destino_asignacion" wire:model.live="id_profesor_asignado"
                                :options="$asignaciones" valueField="id_detalle_profesor_asignado" textField="descripcion_completa"
                                placeholder="SELECCIONA SU ASIGNATURA" class="w-full"
                                errorField="id_profesor_asignado" required />
                        </div>

                        <!-- Tipos de Sección -->
                        <div class="w-full">
                            <span class="block font-bold text-sm text-gray-900 dark:text-white uppercase mb-2">
                                {{ __('Tipos de Sección') }}
                            </span>
                            <div class="flex items-center gap-4 py-2">
                                <label class="inline-flex items-center text-sm font-semibold text-gray-800 dark:text-gray-200 cursor-pointer">
                                    <input type="checkbox" wire:model.live="tipos_seccion" value="1"
                                        class="rounded border-gray-300 text-blue-600 shadow-sm focus:ring-blue-500 mr-2">
                                    Regular
                                </label>
                                <label class="inline-flex items-center text-sm font-semibold text-gray-800 dark:text-gray-200 cursor-pointer">
                                    <input type="checkbox" wire:model.live="tipos_seccion" value="2"
                                        class="rounded border-gray-300 text-blue-600 shadow-sm focus:ring-blue-500 mr-2">
                                    Repitencia
                                </label>
                            </div>
                            <x-input-error :messages="$errors->first('tipos_seccion')" />
                        </div>
                    </div>

                    <!-- Propósito de la unidad -->
                    <div class="w-full">
                        <label for="proposito" class="block font-bold text-sm text-gray-900 dark:text-white uppercase mb-1">
                            {{ __('Propósito de la Unidad') }}
                        </label>
                        <textarea id="proposito" wire:model.live="proposito" rows="3"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white"
                            placeholder="Escriba el propósito de la unidad curricular..."></textarea>
                        <x-input-error :messages="$errors->first('proposito')" />
                    </div>

                    <div class="p-4 bg-yellow-50 dark:bg-yellow-900/30 border-l-4 border-yellow-500 rounded-lg text-sm text-yellow-800 dark:text-yellow-200 mt-4">
                        <div class="font-bold uppercase tracking-wide text-xs mb-1">ATENCIÓN: Carga de Fechas</div>
                        Al importar, esta planificación se duplicará manteniendo absolutamente todos los objetivos, estrategias y evaluaciones (excepto las fechas). Automáticamente será redirigido al editor donde podrá colocar las fechas actualizadas al lapso vigente.
                    </div>

                    <!-- Footer Buttons -->
                    <div class="flex items-center justify-end gap-3 pt-4 border-t border-gray-200 dark:border-gray-700">
                        <x-danger-button type="button" wire:click="closeDuplicarModal" class="px-5 py-2">
                            {{ __('Cancelar') }}
                        </x-danger-button>

                        <x-primary-button type="submit" class="px-5 py-2" wire:loading.attr="disabled">
                            {{ __('Importar Planificación') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    @endif
</div>
