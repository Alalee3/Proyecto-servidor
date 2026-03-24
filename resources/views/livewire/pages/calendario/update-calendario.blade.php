<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Editar Calendario') }}
        </h2>
    </x-slot>

    <x-table.alert-message type="success" :message="session('message')" />
    <x-table.alert-message type="error" :message="session('error')" />

    <div class="sogat-card">
        <form wire:submit.prevent="update" class="w-full space-y-6" novalidate>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                {{-- Fecha Inicio --}}
                <div class="w-full">
                    <x-input-label for="dia_inicio_calendario_academico" :value="__('Fecha de Inicio')" />
                    <x-text-input id="dia_inicio_calendario_academico"
                        wire:model.live="form.dia_inicio_calendario_academico" class="w-full" type="date" required />
                    <x-input-error :messages="$errors->first('form.dia_inicio_calendario_academico')" class="mt-2" />
                </div>

                {{-- Fecha Fin --}}
                <div class="w-full">
                    <x-input-label for="dia_fin_calendario_academico" :value="__('Fecha de Finalización')" />
                    <x-text-input id="dia_fin_calendario_academico" wire:model.live="form.dia_fin_calendario_academico"
                        class="w-full" type="date" required />
                    <x-input-error :messages="$errors->first('form.dia_fin_calendario_academico')" class="mt-2" />
                </div>
            </div>

            <div class="flex items-center justify-end gap-4">
                <a href="{{ route('calendario.list') }}" wire:navigate>
                    <x-primary-button type="button" class="flex items-center gap-1">
                        <span class="material-symbols-outlined text-sm">arrow_back</span>
                        {{ __('Volver') }}
                    </x-primary-button>
                </a>
                <x-primary-button type="submit" wire:loading.attr="disabled">
                    {{ __('Actualizar Calendario') }}
                </x-primary-button>
            </div>
        </form>
    </div>
</div>
