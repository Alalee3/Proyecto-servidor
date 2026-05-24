@php
$showCreateColorModal = $showCreateColorModal ?? false;
$newColorName = $newColorName ?? '';
$newColorCode = $newColorCode ?? '#000000';
@endphp

{{-- Modal para crear nuevo color --}}
<x-modal-base wire:model="showCreateColorModal">
    <div class="p-6">
        {{-- Barra de acento rojo estilo sogat-card --}}
        <div class="border-t-4 border-sogat-red rounded-t-lg -mt-1 mb-5"></div>

        <h3 class="text-xl font-bold text-gray-900 dark:text-gray-100 mb-2 uppercase tracking-widest text-center">
            {{ __('Registrar Nuevo Color') }}
        </h3>
        <p class="text-center text-sm text-gray-500 dark:text-gray-400 mb-6">
            {{ __('El color') }} "<span class="font-semibold text-gray-700 dark:text-gray-200">{{ $newColorName }}</span>" {{ __('no existe. Regístrelo a continuación:') }}
        </p>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            {{-- Nombre del Color --}}
            <div>
                <x-input-label for="modal_newColorName" :value="__('Nombre del Color *')" />
                <x-text-input id="modal_newColorName" type="text" 
                    class="w-full bg-gray-50 dark:bg-gray-900 cursor-not-allowed" 
                    wire:model="newColorName" readonly />
            </div>

            {{-- Código Hexadecimal --}}
            <div>
                <x-input-label for="modal_newColorCode" :value="__('Código Hexadecimal *')" />
                <div class="flex items-center gap-2">
                    <input type="color" id="modal_newColorCode_picker" wire:model.live="newColorCode"
                        class="h-10 w-10 p-1 border border-gray-300 dark:border-gray-700 rounded-md cursor-pointer bg-white dark:bg-gray-900">
                    <x-text-input id="modal_newColorCode" type="text" class="flex-1 font-mono uppercase"
                        wire:model.live="newColorCode" placeholder="#FF0000" maxlength="7" />
                </div>
                <x-input-error :messages="$errors->first('newColorCode')" class="mt-2" />
                <p class="text-xs text-gray-500 mt-1">{{ __('Seleccione un color o introduzca su código hexadecimal.') }}</p>
            </div>
        </div>

        <div class="flex items-center justify-end gap-3 mt-6 pt-4 border-t border-gray-100 dark:border-gray-700">
            <x-secondary-button type="button" wire:click="$set('showCreateColorModal', false)">
                {{ __('Cancelar') }}
            </x-secondary-button>
            <x-primary-button type="button" wire:click="crearColor" wire:loading.attr="disabled">
                {{ __('Guardar Color') }}
            </x-primary-button>
        </div>
    </div>
</x-modal-base>
