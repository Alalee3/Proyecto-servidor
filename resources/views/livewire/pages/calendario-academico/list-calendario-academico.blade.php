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
                <div class="flex flex-col space-y-3 sm:flex-row sm:space-y-0 sm:items-center sm:justify-between p-4 bg-white dark:bg-gray-800">
                    <x-table.search-input model="busqueda" placeholder="Buscar por lapso o semana..." debounce="300ms" />
                </div>

                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Lapso</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-center">Semana</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Inicio</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white">Fin</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">Estatus</th>
                            <th scope="col" class="px-4 py-3 font-medium text-gray-900 dark:text-white text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if ($calendarios->isNotEmpty())
                            @foreach ($calendarios as $cal)
                                <tr wire:key="{{ $cal->id_calendario_academico }}" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">{{ $cal->nombre_lapso }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white text-center">{{ $cal->semana }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($cal->dia_inicio)->format('d/m/Y') }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($cal->dia_fin)->format('d/m/Y') }}</td>
                                    <td class="px-4 py-4 text-right">
                                        <span class="{{ $cal->estatus == 1 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800' }} text-xs font-medium px-2.5 py-0.5 rounded">
                                            {{ $cal->estatus == 1 ? 'Activo' : 'Inactivo' }}
                                        </span>
                                    </td>
                                    <td class="px-4 py-4 text-right">
                                        <div class="flex items-center justify-end space-x-3">
                                            <a href="{{ route('calendario-academico/show', $cal->id_calendario_academico) }}" wire:navigate class="text-blue-600 hover:text-blue-900">Ver</a>
                                            <a href="{{ route('calendario-academico/update', $cal->id_calendario_academico) }}" wire:navigate class="text-yellow-600 hover:text-yellow-900">Editar</a>
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        @else
                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                <td colspan="6" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                                    No hay registros encontrados.
                                </td>
                            </tr>
                        @endif
                    </tbody>
                </table>
            </div>

            <div class="flex flex-col md:flex-row items-center justify-between p-4 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
                <div class="flex items-center mb-4 md:mb-0">
                    <select wire:model.live="paginacion" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white w-24">
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
