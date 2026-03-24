<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Calendario Académico') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 sm:rounded-lg">
            <x-table.alert-message type="success" :message="session('message')" />
            <x-table.alert-message type="error" :message="session('error')" />

            <div class="sogat-table-container">
                <div
                    class="flex flex-col space-y-3 sm:flex-row sm:space-y-0 sm:items-center sm:justify-between p-4 bg-white dark:bg-gray-800">
                    <x-table.search-input model="busqueda" placeholder="Buscar semana..." debounce="300ms" />
                </div>

                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Semana</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Inicio</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Fin</th>
                            @can('cambiar-estatus-calendario')
                                <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">
                                    Estatus</th>
                            @endcan
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if ($calendarios->isNotEmpty())
                            @foreach ($calendarios as $calendario)
                                <tr wire:key="{{ $calendario->id_calendario_academico }}"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">Semana
                                        {{ $calendario->semana_calendario_academico }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->format('d/m/Y') }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->format('d/m/Y') }}</td>
                                    @can('cambiar-estatus-calendario')
                                        <td class="px-4 py-4 text-right">
                                            <span
                                                class="{{ $calendario->estatus == 1 ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300' : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300' }} text-xs font-medium px-2.5 py-0.5 rounded">
                                                {{ $calendario->estatus == 1 ? 'Activo' : 'Inactivo' }}
                                            </span>
                                        </td>
                                    @endcan
                                    <td class="px-4 py-4">
                                        <div class="flex items-center justify-end space-x-3">
                                            @can('ver-calendario')
                                                <a href="{{ route('calendario.show', $calendario->id_calendario_academico) }}"
                                                    wire:navigate
                                                    class="flex items-center gap-1 bg-blue-50 text-blue-600 text-xs font-medium px-2.5 py-0.5 rounded hover:bg-blue-100 dark:bg-blue-900 dark:text-blue-200 dark:hover:bg-blue-800">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24"
                                                        class="w-4 h-4">
                                                        <path
                                                            d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z" />
                                                    </svg>
                                                    Ver
                                                </a>
                                            @endcan
                                            @can('editar-calendario')
                                                <a href="{{ route('calendario.update', $calendario->id_calendario_academico) }}"
                                                    wire:navigate
                                                    class="flex items-center gap-1 bg-yellow-600 text-white text-xs font-medium px-2.5 py-0.5 rounded hover:bg-yellow-700 dark:bg-yellow-600 dark:text-white dark:hover:bg-yellow-700">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24"
                                                        class="w-4 h-4">
                                                        <path
                                                            d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" />
                                                    </svg>
                                                    Editar
                                                </a>
                                            @endcan
                                        </div>
                                    </td>

                                </tr>
                            @endforeach
                        @else
                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                <td colspan="{{ auth()->user()->can('cambiar-estatus-calendario') ? 5 : 4 }}"
                                    class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                                    {{ $busqueda ? 'No se encontraron registros' : 'No hay semanas registradas' }}
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
                <div>{{ $calendarios->links() }}</div>
            </div>
        </div>
    </div>
</div>
