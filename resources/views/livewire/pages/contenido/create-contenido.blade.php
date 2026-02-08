<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Crear Contenido') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <!-- Alertas -->
            <x-table.alert-message type="success" :message="session('message')" />
            <x-table.alert-message type="error" :message="session('error')" />

            <div class="sogat-card">
                <form wire:submit.prevent="save" class="w-full space-y-6" novalidate>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Tema -->
                        <div class="w-full">
                            <x-input-label for="tema" :value="__('Tema Asociado')" />
                            <x-select id="tema" wire:model.live="form.id_tema" :options="$temas" valueField="id"
                                textField="nombre" placeholder="Selecciona un tema" class="w-full mt-1"
                                errorField="form.id_tema" required />
                        </div>

                        <!-- Título -->
                        <div class="w-full">
                            <x-input-label for="titulo" :value="__('Título del Contenido')" />
                            <x-text-input id="titulo" wire:model.live="form.titulo_contenido" class="w-full mt-1"
                                type="text" placeholder="Ej: Introducción a la Informática" required />
                            <x-input-error :messages="$errors->first('form.titulo_contenido')" class="mt-2" />
                        </div>
                    </div>


                    <!-- Botones -->
                    <div class="flex items-center justify-end gap-4">
                        <x-primary-button type="submit" wire:loading.attr="disabled">
                            {{ __('Guardar Contenido') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

