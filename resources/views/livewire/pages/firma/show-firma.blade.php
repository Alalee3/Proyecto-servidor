<div>
    <x-slot name="header">
        <h2
            class="font-semibold text-xl text-center {{ $firma && $firma->estatus != 1 ? 'text-red-600 dark:text-red-400' : 'text-gray-800 dark:text-gray-500' }} leading-tight uppercase">
            {{ $firma && $firma->estatus != 1 ? __('Detalles de Firma Inactiva') : __('Detalles de la Firma') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">

                @if ($firma)
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-6">
                        <div>
                            <x-input-label value="Usuario:" />
                            <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold break-words overflow-hidden">
                                {{ $firma->usuario->name ?? 'N/A' }}
                            </p>
                            @if ($firma->usuario)
                                <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
                                    C.I: {{ $firma->usuario->usu_cedula }}
                                </p>
                            @endif
                        </div>

                        <div>
                            <x-input-label value="Estatus:" />
                            <p class="text-gray-700 dark:text-gray-300 text-2xl font-semibold">
                                <span
                                    class="{{ $firma->estatus == 1
                                        ? 'px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-600 dark:text-green-100'
                                        : 'px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:bg-red-600 dark:text-red-100' }}">
                                    {{ $firma->estatus == 1 ? 'Activo' : 'Inactivo' }}
                                </span>
                            </p>
                        </div>
                    </div>

                    <!-- Vista de la firma -->
                    <div class="border-t border-gray-200 dark:border-gray-700 pt-6">
                        <x-input-label value="Imagen de la Firma:" class="mb-3" />
                        <div class="flex items-center justify-center p-8 bg-white dark:bg-gray-800 border-2 border-gray-200 dark:border-gray-700 rounded-lg"
                            style="background-image: radial-gradient(circle, #cccccc 1px, transparent 1px); background-size: 10px 10px;">
                            @if ($firma->foto_base64)
                                <img src="{{ $firma->foto_base64 }}" 
                                    alt="Firma de {{ $firma->usuario->name ?? '' }}"
                                    class="max-h-48 w-auto object-contain"
                                    style="image-rendering: auto;">
                            @else
                                <div class="text-center text-gray-400 dark:text-gray-500">
                                    <svg class="mx-auto h-16 w-16 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                                    </svg>
                                    <p class="text-sm">Sin firma registrada</p>
                                </div>
                            @endif
                        </div>
                        @if ($firma->foto_base64)
                            <p class="text-xs text-gray-500 dark:text-gray-400 mt-2 text-center">
                                ✅ Firma con fondo transparente (PNG) — lista para usar en documentos.
                            </p>
                        @endif
                    </div>
                @else
                    <p class="text-gray-500 dark:text-gray-400">No se ha encontrado la firma...</p>
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
