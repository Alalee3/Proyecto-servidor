<div>
    <x-slot name="header">
        <h2
            class="font-semibold text-xl text-center {{ $color && $color->estatus != 1 ? 'text-red-600 dark:text-red-400' : 'text-gray-800 dark:text-gray-500' }} leading-tight uppercase">
            {{ $color && $color->estatus != 1 ? __('Detalles del Color Inactivo') : __('Detalles del Color') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">

                @if ($color)
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
                        <div>
                            <x-input-label value="Nombre del Color:" />
                            <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold break-words overflow-hidden">
                                {{ $color->nombre_color }}
                            </p>
                        </div>

                        <div>
                            <x-input-label value="Código Hexadecimal:" />
                            <div class="flex items-center gap-3 mt-1">
                                <span class="w-12 h-12 rounded-lg border border-gray-300 dark:border-gray-600 shadow-md"
                                    style="background-color: {{ $color->codigo_color }}"></span>
                                <span class="text-2xl font-mono text-gray-700 dark:text-gray-300 font-semibold">{{ strtoupper($color->codigo_color) }}</span>
                            </div>
                        </div>

                        <div>
                            <x-input-label value="Estatus:" />
                            <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold">
                                <span
                                    class="{{ $color->estatus == 1
                                        ? 'px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-600 dark:text-green-100'
                                        : 'px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:bg-red-600 dark:text-red-100' }}">
                                    {{ $color->estatus == 1 ? 'Activo' : 'Inactivo' }}
                                </span>
                            </p>
                        </div>
                    </div>
                @else
                    <p class="text-gray-500 dark:text-gray-400">No se ha encontrado el color...</p>
                @endif

                <div class="flex justify-end mt-6">
                    <x-danger-button type="button" wire:click="cerrar">
                        <link rel="stylesheet"
                            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_back" />
                        <span class="material-symbols-outlined">arrow_back</span>
                        {{ __('Volver') }}
                    </x-danger-button>
                </div>
            </div>
        </div>
    </div>
</div>
