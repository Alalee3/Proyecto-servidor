<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Registrar Color') }}
        </h2>
    </x-slot>

    <x-table.alert-message />

    <div class="sogat-card">
        <form wire:submit.prevent="guardar" class="w-full space-y-6" novalidate>
            <!-- Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Nombre del Color -->
                <div class="w-full">
                    <x-datalist 
                        wire:key="datalist-colores-{{ md5($coloresExistentes->pluck('nombre_color')->join(',')) }}"
                        label="Nombre del Color" 
                        :options="$coloresExistentes" 
                        textField="nombre_color"
                        wire:model.live="form.nombre_color"
                        placeholder="Ej: Rojo Pasión"
                        required 
                    />
                </div>

                <!-- Código de Color -->
                <div class="w-full">
                    <x-input-label for="codigo_color" :value="__('Código Hexadecimal *')" />
                    <div class="flex items-center gap-2">
                        <input type="color" id="color_picker" wire:model.live="form.codigo_color" class="h-10 w-10 p-1 border border-gray-300 dark:border-gray-700 rounded-md cursor-pointer bg-white dark:bg-gray-900">
                        <x-text-input id="codigo_color" type="text" class="flex-1 font-mono uppercase" wire:model.live="form.codigo_color" placeholder="#FF0000" maxlength="7" required />
                    </div>
                    <x-input-error :messages="$errors->first('form.codigo_color')" class="mt-2" />
                    <p class="text-xs text-gray-500 mt-1">Seleccione un color o introduzca su código hexadecimal.</p>
                </div>
            </div>

            <!-- Boton Guardar -->
            <div class="flex items-center justify-end gap-4">
                <x-primary-button type="submit" wire:loading.attr="disabled">
                    {{ __('Guardar Color') }}
                </x-primary-button>
            </div>
        </form>
    </div>
</div>
