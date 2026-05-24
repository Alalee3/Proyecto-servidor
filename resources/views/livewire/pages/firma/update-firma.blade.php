<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Editar Firma Digital') }}
        </h2>
    </x-slot>

    <x-table.alert-message />

    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">
                <form wire:submit.prevent="actualizar" class="w-full space-y-6" novalidate>
                    <!-- Info -->
                    <div class="bg-blue-50 dark:bg-blue-900/30 border border-blue-200 dark:border-blue-800 rounded-lg p-4">
                        <div class="flex items-start gap-3">
                            <svg class="w-5 h-5 text-blue-600 dark:text-blue-400 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            <div>
                                <p class="text-sm text-blue-700 dark:text-blue-300 font-medium">Información</p>
                                <p class="text-xs text-blue-600 dark:text-blue-400 mt-1">
                                    Si seleccionas una nueva imagen, el sistema <strong>eliminará automáticamente el fondo</strong>
                                    y la convertirá a PNG transparente.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-6">
                        <!-- Nueva Imagen -->
                        <div class="w-full max-w-lg mx-auto">
                            <x-input-label for="foto_firma_edit" :value="__('Nueva Imagen de Firma (opcional)')" />
                            <div class="mt-1"
                                x-data="{ 
                                    preview: null,
                                    isDragging: false,
                                    uploading: false,
                                    handleDrop(e) {
                                        e.preventDefault();
                                        this.isDragging = false;
                                        const file = e.dataTransfer.files[0];
                                        if (file) {
                                            this.preview = URL.createObjectURL(file);
                                            this.uploading = true;
                                            this.$wire.upload('form.foto_firma', file, () => {
                                                this.uploading = false;
                                            }, () => {
                                                this.uploading = false;
                                            });
                                        }
                                    },
                                    handleClick() {
                                        this.$refs.fileInputEdit.click();
                                    },
                                    onFileSelect(e) {
                                        const file = e.target.files[0];
                                        if (file) {
                                            this.preview = URL.createObjectURL(file);
                                            this.uploading = true;
                                            this.$wire.upload('form.foto_firma', file, () => {
                                                this.uploading = false;
                                            }, () => {
                                                this.uploading = false;
                                            });
                                        }
                                    },
                                    clearFile() {
                                        this.preview = null;
                                        this.uploading = false;
                                        this.$refs.fileInputEdit.value = '';
                                        this.$wire.set('form.foto_firma', null);
                                    }
                                }"
                                @dragover.prevent="isDragging = true"
                                @dragleave.prevent="isDragging = false"
                                @drop.prevent="handleDrop"
                                @click="handleClick"
                                :class="{
                                    'border-sogat-blue dark:border-blue-500 bg-blue-50 dark:bg-blue-900/20': isDragging,
                                    'border-gray-300 dark:border-gray-600': !isDragging && !preview
                                }"
                                class="flex justify-center px-6 pt-5 pb-6 border-2 border-dashed rounded-lg transition-all duration-200 cursor-pointer hover:border-sogat-blue dark:hover:border-blue-500">
                                
                                <!-- Estado inicial -->
                                <template x-if="!preview && !uploading">
                                    <div class="space-y-2 text-center">
                                        <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
                                            <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                        <div class="flex text-sm text-gray-600 dark:text-gray-400">
                                            <span class="relative cursor-pointer rounded-md font-medium text-sogat-blue hover:text-blue-500">
                                                <span>Seleccionar archivo</span>
                                            </span>
                                            <p class="pl-1">o arrastra la imagen aquí</p>
                                        </div>
                                        <p class="text-xs text-gray-500 dark:text-gray-400">PNG, JPG, GIF, WebP hasta 10MB</p>
                                    </div>
                                </template>
                                
                                <!-- Estado: subiendo -->
                                <template x-if="uploading">
                                    <div class="space-y-2 text-center">
                                        <svg class="mx-auto h-12 w-12 text-sogat-blue dark:text-blue-400 animate-spin" fill="none" viewBox="0 0 24 24">
                                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                        </svg>
                                        <p class="text-sm font-medium text-sogat-blue dark:text-blue-400">Subiendo imagen...</p>
                                    </div>
                                </template>
                                
                                <!-- Estado: arrastrando -->
                                <template x-if="isDragging && !preview && !uploading">
                                    <div class="space-y-2 text-center">
                                        <svg class="mx-auto h-12 w-12 text-sogat-blue dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                                        </svg>
                                        <p class="text-sm font-medium text-sogat-blue dark:text-blue-400">Suelta la imagen aquí</p>
                                    </div>
                                </template>
                                
                                <!-- Estado: con preview -->
                                <template x-if="preview && !uploading">
                                    <div class="relative w-full">
                                        <img :src="preview" class="max-h-48 mx-auto object-contain rounded border border-gray-200 dark:border-gray-700">
                                        <button type="button" @click.stop="clearFile()" 
                                            class="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs hover:bg-red-600 shadow transition-transform hover:scale-110">
                                            ✕
                                        </button>
                                    </div>
                                </template>

                                <!-- Input file oculto -->
                                <input id="foto_firma_edit" type="file" class="hidden" x-ref="fileInputEdit"
                                    accept="image/*"
                                    @change="onFileSelect">
                            </div>
                            <x-input-error :messages="$errors->get('form.foto_firma')" class="mt-2" />
                            <p wire:loading wire:target="form.foto_firma" class="text-xs text-blue-600 mt-1">Subiendo imagen...</p>
                        </div>
                    </div>

                    <!-- Firma actual -->
                    @if ($form->foto_preview)
                        <div class="border border-gray-200 dark:border-gray-700 rounded-lg p-4 bg-gray-50 dark:bg-gray-900">
                            <p class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Firma actual:</p>
                            <div class="flex items-center justify-center p-4 bg-white dark:bg-gray-800 rounded border border-gray-200 dark:border-gray-700"
                                style="background-image: radial-gradient(circle, #cccccc 1px, transparent 1px); background-size: 10px 10px;">
                                <img src="{{ $form->foto_preview }}" 
                                    class="max-h-24 w-auto object-contain"
                                    style="image-rendering: auto;">
                            </div>
                            <p class="text-xs text-gray-500 dark:text-gray-400 mt-1 text-center">
                                Firma actual
                            </p>
                        </div>
                    @endif

                    <!-- Nueva vista previa -->
                    @if ($form->foto_firma)
                        <div class="border border-green-200 dark:border-green-700 rounded-lg p-4 bg-green-50 dark:bg-green-900/30">
                            <p class="text-sm font-medium text-green-700 dark:text-green-300 mb-2">Nueva firma (se procesará al guardar):</p>
                            <div class="flex items-center justify-center p-4 bg-white dark:bg-gray-800 rounded border border-gray-200 dark:border-gray-700"
                                style="background-image: radial-gradient(circle, #cccccc 1px, transparent 1px); background-size: 10px 10px;">
                                <img src="{{ $form->foto_firma->temporaryUrl() }}" 
                                    class="max-h-24 w-auto object-contain"
                                    style="image-rendering: auto;">
                            </div>
                        </div>
                    @endif

                    <!-- Botones -->
                    <div class="flex items-center justify-end gap-4">
                        <x-danger-button type="button" wire:click="cancelar">
                            <link rel="stylesheet"
                                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_back" />
                            <span class="material-symbols-outlined">arrow_back</span>
                            {{ __('Volver') }}
                        </x-danger-button>

                        <x-primary-button type="submit" wire:loading.attr="disabled">
                            {{ __('Actualizar Firma') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
