<div>
    <x-slot name="header">
        <h2
            class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight uppercase text-center text-gray-500 dark:text-gray-500">
            {{ __('Detalles del Permiso') }}
        </h2>
    </x-slot>

    <div class="sogat-card">
        <div class="space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <!-- Nombre -->
                <div>
                    <h3 class="text-sm font-medium text-gray-500 dark:text-gray-400">Nombre del Permiso</h3>
                    <p class="mt-1 text-2xl font-semibold text-gray-900 dark:text-white">
                        {{ $permiso->nombre_permiso }}
                    </p>
                </div>
            </div>

            <div class="flex justify-end pt-4">
                <a href="{{ route('permiso/listar') }}" wire:navigate>
                    <x-danger-button type="button" class="flex items-center gap-1">
                        <span class="material-symbols-outlined text-sm">arrow_back</span>
                        {{ __('Volver') }}
                    </x-danger-button>
                </a>
            </div>
        </div>
    </div>
</div>