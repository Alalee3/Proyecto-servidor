<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            Notas del Calendario
        </h2>
    </x-slot>

    <x-table.alert-message />

    <div class="sogat-card">

        <form wire:submit.prevent="agregarNota" class="w-full space-y-6" novalidate>
            <div class="flex flex-col gap-4 w-full md:flex-row items-end">
                <div class="w-full">
                    <x-input label="Añadir Nueva Nota" name="nuevaNota" errorField="form.nuevaNota"
                        wire:model.live="form.nuevaNota" placeholder="Escriba aquí la nota o consideración..."
                        required />
                </div>
                <div class="mb-4 shrink-0">
                    <x-primary-button type="submit" wire:loading.attr="disabled">
                        {{ __('Guardar Nota') }}
                    </x-primary-button>
                </div>
            </div>
        </form>

        <div class="mt-8">
            <h4 class="text-md font-semibold text-gray-700 dark:text-gray-300 mb-4 border-b pb-2 dark:border-gray-700">
                Notas Registradas</h4>

            @if(count($form->notas) > 0)
                <ul class="space-y-4">
                    @foreach($form->notas as $index => $nota)
                        <li
                            class="flex items-start justify-between bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg border border-gray-200 dark:border-gray-600">
                            <div class="flex-1 text-sm text-gray-800 dark:text-gray-200 pr-6">
                                {{ $nota }}
                            </div>
                            <button wire:click="eliminarNota({{ $index }})"
                                wire:confirm="¿Está seguro de eliminar esta nota de forma permanente?"
                                class="text-red-500 hover:text-red-700 hover:bg-red-50 dark:hover:bg-red-900/30 p-2 rounded-full transition-colors flex-shrink-0"
                                title="Eliminar nota">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16">
                                    </path>
                                </svg>
                            </button>
                        </li>
                    @endforeach
                </ul>
            @else
                <div
                    class="text-center py-8 bg-gray-50 dark:bg-gray-700/30 rounded-lg border border-dashed border-gray-300 dark:border-gray-600">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                        aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900 dark:text-gray-200">No hay notas</h3>
                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">Actualmente no existen notas o consideraciones
                        para este calendario.</p>
                </div>
            @endif
        </div>

        <div class="flex items-center justify-end gap-4 mt-8 pt-4 border-t border-gray-200 dark:border-gray-700">
            <x-danger-button type="button" wire:click="cancelar">
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_back" />
                <span class="material-symbols-outlined">
                    arrow_back
                </span>
                {{ __('Volver') }}
            </x-danger-button>
        </div>
    </div>
</div>