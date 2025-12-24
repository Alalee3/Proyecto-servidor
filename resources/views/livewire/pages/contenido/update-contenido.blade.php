<div>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-500 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Editar Contenido') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="p-4 sm:p-8 bg-white dark:bg-gray-800 shadow sm:rounded-lg">
                <form wire:submit="save" class="w-full space-y-6">

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <!-- Título -->
                        <div class="w-full">
                            <x-input-label for="titulo" :value="__('Título del Contenido')" />
                            <x-text-input id="titulo" wire:model="form.titulo_contenido" class="w-full mt-1" type="text"
                                required />
                            <x-input-error :messages="$errors->first('form.titulo_contenido')" class="mt-2" />
                        </div>

                        <!-- Unidad Curricular -->
                        <div class="w-full">
                            <x-input-label for="unidad" :value="__('Unidad Curricular')" />
                            <x-select id="unidad" wire:model="form.id_unidad_curricular" :options="$unidades"
                                valueField="id" textField="nombre" placeholder="Selecciona una unidad"
                                class="w-full mt-1" />
                            <!-- x-select handles its own error, but if we want consistency we might disable it there? 
                                 For now, letting x-select handle it is safer as it binds to the field. 
                                 UpdatePnf uses x-input-error external. 
                                 I will remove x-select's internal error if it doubles up, but x-select code shows it renders error. 
                                 I won't add x-input-error here to avoid duplication.
                            -->
                        </div>

                        <!-- Corte -->
                        <div class="w-full">
                            <x-input-label for="corte" :value="__('Corte')" />
                            <select id="corte" wire:model="form.corte_contenido"
                                class="border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm w-full mt-1">
                                <option value="">Selecciona un corte</option>
                                <option value="1">Corte 1</option>
                                <option value="2">Corte 2</option>
                                <option value="3">Corte 3</option>
                                <option value="4">Corte 4</option>
                            </select>
                            <x-input-error :messages="$errors->first('form.corte_contenido')" class="mt-2" />
                        </div>
                    </div>

                    <!-- Descripción (Full Width) -->
                    <div class="w-full">
                        <x-input-label for="descripcion" :value="__('Descripción (Opcional)')" />
                        <textarea id="descripcion" wire:model="form.descripcion_contenido" rows="4"
                            class="border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm w-full mt-1"></textarea>
                        <x-input-error :messages="$errors->first('form.descripcion_contenido')" class="mt-2" />
                    </div>

                    <!-- Botones -->
                    <div class="flex items-center justify-end gap-4">
                        <a href="{{ route('contenido/listar') }}">
                            <x-danger-button type="button">
                                <link rel="stylesheet"
                                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_back" />
                                <span class="material-symbols-outlined">
                                    arrow_back
                                </span>
                                {{ __('Volver') }}
                            </x-danger-button>
                        </a>

                        <x-primary-button type="submit" wire:loading.attr="disabled">
                            {{ __('Actualizar') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>