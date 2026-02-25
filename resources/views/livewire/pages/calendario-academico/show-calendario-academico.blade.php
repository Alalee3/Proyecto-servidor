<div>
    <x-slot name="header">
        <h2
            class="font-semibold text-xl text-center {{ $calendario && $calendario->estatus != 1 ? 'text-red-600' : 'text-gray-500' }} leading-tight uppercase">
            {{ __('Detalles de Calendario Académico') }}
        </h2>
    </x-slot>

    <div class="sogat-card">
        @if ($calendario)
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <x-input-label value="Lapso Académico:" />
                    <p class="text-gray-900 dark:text-white text-2xl font-semibold">{{ $calendario->nombre_lapso }}</p>
                </div>

                <div>
                    <x-input-label value="Semana:" />
                    <p class="text-gray-900 dark:text-white text-2xl font-semibold">
                        {{ $calendario->semana_calendario_academico }}
                    </p>
                </div>

                <div>
                    <x-input-label value="Fecha Inicio:" />
                    <p class="text-gray-900 dark:text-white text-2xl font-semibold">
                        {{ \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->format('d/m/Y') }}
                    </p>
                </div>

                <div>
                    <x-input-label value="Fecha Fin:" />
                    <p class="text-gray-900 dark:text-white text-2xl font-semibold">
                        {{ \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->format('d/m/Y') }}
                    </p>
                </div>

                <div>
                    <x-input-label value="Estatus:" />
                    <p class="text-gray-900 dark:text-white text-2xl font-semibold">
                        <span class="{{ $calendario->estatus == 1 ? 'text-green-600' : 'text-red-600' }}">
                            {{ $calendario->estatus == 1 ? 'Activo' : 'Inactivo' }}
                        </span>
                    </p>
                </div>
            </div>

            <div class="mt-10 border-t border-gray-200 dark:border-gray-700 pt-6">
                <h3 class="text-lg font-bold text-gray-800 dark:text-gray-400 mb-4 uppercase">
                    {{ __('Eventos Asociados') }}
                </h3>

                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" class="px-4 py-3">Semana</th>
                                <th scope="col" class="px-4 py-3">Descripción</th>
                                <th scope="col" class="px-4 py-3">Inicio</th>
                                <th scope="col" class="px-4 py-3">Fin</th>
                                <th scope="col" class="px-4 py-3 text-center">Tipo</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($eventos as $evento)
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td class="px-4 py-4 text-gray-900 dark:text-white font-medium">{{ $evento->semana_evento }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">{{ $evento->descripcion_evento }}</td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($evento->dia_inicio_evento)->format('d/m/Y') }}
                                    </td>
                                    <td class="px-4 py-4 text-gray-900 dark:text-white">
                                        {{ \Carbon\Carbon::parse($evento->dia_fin_evento)->format('d/m/Y') }}
                                    </td>
                                    <td class="px-4 py-4 text-center">
                                        @php
                                            $tipo = match($evento->tipo_evento) {
                                                '1' => ['label' => 'Feriado', 'class' => 'bg-red-100 text-red-800'],
                                                '2' => ['label' => 'Académica', 'class' => 'bg-blue-100 text-blue-800'],
                                                '3' => ['label' => 'Otro', 'class' => 'bg-gray-100 text-gray-800'],
                                                default => ['label' => 'Desconocido', 'class' => 'bg-gray-50 text-gray-400'],
                                            };
                                        @endphp
                                        <span class="{{ $tipo['class'] }} text-xs font-medium px-2.5 py-0.5 rounded uppercase">
                                            {{ $tipo['label'] }}
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="5" class="px-4 py-4 text-center text-gray-500">
                                        No hay eventos registrados para este calendario.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        @else
            <p class="text-gray-500">No se encontró el registro.</p>
        @endif

        <div class="flex justify-end mt-6">
            <a href="{{ route('calendario-academico/listar') }}" wire:navigate>
                <x-danger-button type="button" class="flex items-center gap-1">
                    <span class="material-symbols-outlined">arrow_back</span>
                    {{ __('Volver') }}
                </x-danger-button>
            </a>
        </div>
    </div>
</div>