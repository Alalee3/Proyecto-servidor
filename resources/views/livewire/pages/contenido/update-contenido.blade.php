<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Editar Contenido') }}
        </h2>
    </x-slot>

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">
                <form wire:submit="save" class="w-full space-y-6">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        <!-- Tema -->
                        <div class="w-full">
                            <x-input-label for="tema" :value="__('Tema Asociado')" class="text-gray-600 font-bold mb-1" />
                            <x-select id="tema" wire:model.live="form.id_tema" :options="$temas" valueField="id"
                                textField="nombre" placeholder="Selecciona un tema" class="w-full"
                                errorField="form.id_tema" required />
                        </div>

                        <!-- Selección Dinámica de Objetivos (Selects Repetibles) -->
                        <div class="w-full md:col-span-2">
                            <div class="flex items-center justify-between mb-2">
                                <x-input-label :value="__('Objetivos Específicos')" class="text-gray-600 font-bold" />
                                <button type="button" wire:click="addObjetivo" 
                                    class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-3 py-1 rounded-md font-bold transition-colors uppercase">
                                    + Agregar Objetivo
                                </button>
                            </div>
                            
                            <div class="space-y-4">
                                @foreach($form->id_objetivo as $index => $idSel)
                                    <div class="flex items-center gap-3">
                                        <div class="flex-grow">
                                            <x-select id="objetivo_{{ $index }}" 
                                                wire:model.live="form.id_objetivo.{{ $index }}" 
                                                :options="$objetivos" valueField="id" textField="nombre" 
                                                :placeholder="empty($form->id_tema) ? '-- PRIMERO ELIJA UN TEMA --' : 'SELECCIONA UN OBJETIVO'" 
                                                class="w-full"
                                                :disabled="empty($form->id_tema)" />
                                        </div>
                                        <button type="button" wire:click="removeObjetivo({{ $index }})" 
                                            class="text-gray-400 hover:text-red-500 transition-colors p-2"
                                            title="ELIMINAR ESTE OBJETIVO">
                                            <span class="material-icons text-xl">delete</span>
                                        </button>
                                    </div>
                                @endforeach
                            </div>
                            <x-input-error :messages="$errors->first('form.id_objetivo')" class="mt-2" />
                        </div>

                        <!-- Título -->
                        <div class="w-full md:col-span-2">
                            <x-input-label for="titulo" :value="__('Título del Contenido')" class="text-gray-600 font-bold mb-1" />
                            <x-text-input id="titulo" wire:model="form.titulo_contenido" class="w-full" type="text"
                                placeholder="EJ: INVOCACIÓN DE MÉTODOS Y PASO DE PARÁMETROS" required />
                            <x-input-error :messages="$errors->first('form.titulo_contenido')" class="mt-2" />
                        </div>
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

                        <x-primary-button type="submit" wire:loading.attr="disabled"
                            class="bg-gray-600 hover:bg-gray-700 text-white border-none transition-all shadow-lg active:scale-95">
                            {{ __('Actualizar Contenido') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

