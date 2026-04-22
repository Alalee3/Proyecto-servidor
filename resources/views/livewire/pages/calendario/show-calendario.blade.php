<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Detalles de Semana') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">
                <!-- Grid de información - 3 columnas como en Recurso -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-6">

                    {{-- Semana --}}
                    <div>
                        <x-input-label value="Número de Semana:" />
                        <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold">
                            Semana {{ $calendario->semana_calendario_academico }}
                        </p>
                    </div>

                    {{-- Estatus --}}
                    <div>
                        <x-input-label value="Estatus:" />
                        <p class="mt-1">
                            <span class="{{ $calendario->estatus == 1
    ? 'px-3 py-1 text-lg font-bold text-green-700 bg-green-100 rounded-full dark:bg-green-900 dark:text-green-300'
    : 'px-3 py-1 text-lg font-bold text-red-700 bg-red-100 rounded-full dark:bg-red-900 dark:text-red-300' }}">
                                {{ $calendario->estatus == 1 ? 'Activo' : 'Inactivo' }}
                            </span>
                        </p>
                    </div>

                    {{-- Fecha Inicio --}}
                    <div>
                        <x-input-label value="Fecha de Inicio:" />
                        <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold">
                            {{ \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->format('d/m/Y') }}
                        </p>
                    </div>

                    {{-- Fecha Fin --}}
                    <div>
                        <x-input-label value="Fecha de Finalización:" />
                        <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold">
                            {{ \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->format('d/m/Y') }}
                        </p>
                    </div>

                    </div>
                </div>

                {{-- Acciones --}}
                <div class="flex justify-end gap-4 pt-4">
                    <a href="{{ route('calendario.list') }}" wire:navigate>
                        <x-danger-button type="button" class="flex items-center gap-1">
                            <span class="material-symbols-outlined text-sm">arrow_back</span>
                            {{ __('Volver') }}
                        </x-danger-button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>