<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Permisos') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 sm:rounded-lg">
            <x-table.alert-message type="success" :message="session('message')" />
            <x-table.alert-message type="error" :message="session('error')" />

            <div class="sogat-table-container">
                <div
                    class="flex flex-col space-y-3 sm:flex-row sm:space-y-0 sm:items-center sm:justify-between p-4 bg-white dark:bg-gray-800">
                    <x-table.search-input model="busqueda" placeholder="Buscar permiso..." debounce="300ms" />
                </div>

                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">ID</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Nombre del
                                Permiso</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Fecha de
                                Creación</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">
                                Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if ($permisos->isNotEmpty())
                            @foreach ($permisos as $permiso)
                                <tr wire:key="{{ $permiso->id_permiso }}"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">{{ $permiso->id_permiso }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white font-semibold">
                                        {{ $permiso->nombre_permiso }}
                                    </td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($permiso->fecha_creacion)->format('d/m/Y') }}
                                    </td>
                                    <td class="px-4 py-4">
                                        <div class="flex items-center justify-end space-x-3">
                                            <a href="{{ route('permiso/show', $permiso->id_permiso) }}" wire:navigate
                                                class="flex items-center gap-1 bg-blue-50 text-blue-600 text-xs font-medium px-2.5 py-0.5 rounded hover:bg-blue-100 dark:bg-blue-900 dark:text-blue-200 dark:hover:bg-blue-800">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24"
                                                    class="w-4 h-4">
                                                    <path
                                                        d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z" />
                                                </svg>
                                                Ver
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        @else
                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                <td colspan="4" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                                    {{ $busqueda ? 'No se encontraron permisos' : 'No hay permisos registrados' }}
                                </td>
                            </tr>
                        @endif
                    </tbody>
                </table>
            </div>

            <div
                class="flex flex-col md:flex-row items-center justify-between p-4 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
                <div class="flex items-center mb-4 md:mb-0">
                    <select wire:model.live="paginacion"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white w-24">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                    </select>
                </div>
                <div>{{ $permisos->links() }}</div>
            </div>
        </div>
    </div>
</div>