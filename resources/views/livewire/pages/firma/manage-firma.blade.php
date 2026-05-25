<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Mi Firma Digital') }}
        </h2>
    </x-slot>

    <x-table.alert-message />

    <div class="sogat-card">
        <div class="space-y-6">

            <!-- Firma Actual + Subida integrados -->
            <form wire:submit.prevent="guardar" class="w-full space-y-6" novalidate>
                <div class="grid grid-cols-1 gap-5">

                    <!-- Imagen de la firma actual (si existe) -->
                    @if ($firmaActual)
                        <div class="flex flex-col items-center">
                            <div class="bg-white p-5 rounded-lg shadow-inner border border-gray-200 dark:border-gray-700"
                                style="background-image: radial-gradient(circle, #e5e7eb 1px, transparent 1px); background-size: 15px 15px;">
                                <img src="{{ $firmaActual->foto_base64 }}" alt="Firma Actual"
                                    class="max-h-40 object-contain drop-shadow-md">
                            </div>
                        </div>
                    @else
                        <div
                            class="bg-yellow-50 dark:bg-yellow-900/30 border border-yellow-200 dark:border-yellow-800 rounded-lg p-3">
                            <p class="text-xs text-yellow-700 dark:text-yellow-300 text-center">
                                Aún no tienes una firma registrada. Selecciona un archivo para subirla.
                            </p>
                        </div>
                    @endif
                    <!-- Drop zone -->
                    <div>
                        <div x-data="{ 
                                preview: null,
                                uploading: false,
                                handleClick() {
                                    $dispatch('show-alert', {
                                        type: 'warning',
                                        message: 'Para un resultado óptimo, asegúrate de subir una foto donde tu firma esté centrada, escrita en una hoja blanca, con buena iluminación (sin sombras fuertes) y el trazo sea visible y claro.',
                                        onOkEvent: 'open-file-picker'
                                    });
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
                                    this.$refs.fileInput.value = '';
                                    this.$wire.set('form.foto_firma', null);
                                }
                            }" @click="handleClick" @open-file-picker.window="$refs.fileInput.click()"
                            class="flex justify-center px-6 pt-5 pb-6 border-2 border-dashed rounded-lg transition-all duration-200 cursor-pointer hover:border-sogat-blue dark:hover:border-blue-500 border-gray-300 dark:border-gray-600">

                            <!-- Estado inicial: sin imagen -->
                            <template x-if="!preview && !uploading">
                                <div class="space-y-2 text-center">
                                    <svg class="mx-auto h-10 w-10 text-gray-400" stroke="currentColor" fill="none"
                                        viewBox="0 0 48 48">
                                        <path
                                            d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <div class="flex flex-col items-center text-sm text-gray-600 dark:text-gray-400">
                                        <span
                                            class="relative cursor-pointer rounded-md font-medium text-sogat-blue hover:text-blue-500">
                                            <span>Haz clic para seleccionar una foto si deseas actualizar su firma.</span>
                                        </span>
                                    </div>
                                    <p class="text-xs text-gray-500 dark:text-gray-400">PNG, JPG, GIF, WebP — máx. 10MB
                                    </p>
                                </div>
                            </template>

                            <!-- Estado: subiendo -->
                            <template x-if="uploading">
                                <div class="space-y-2 text-center">
                                    <svg class="mx-auto h-10 w-10 text-sogat-blue dark:text-blue-400 animate-spin"
                                        fill="none" viewBox="0 0 24 24">
                                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                            stroke-width="4"></circle>
                                        <path class="opacity-75" fill="currentColor"
                                            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                        </path>
                                    </svg>
                                    <p class="text-sm font-medium text-sogat-blue dark:text-blue-400">Subiendo imagen...
                                    </p>
                                </div>
                            </template>


                            <!-- Estado: con preview -->
                            <template x-if="preview && !uploading">
                                <div class="relative w-full">
                                    <img :src="preview"
                                        class="max-h-40 mx-auto object-contain rounded border border-gray-200 dark:border-gray-700">
                                    <button type="button" @click.stop="clearFile()"
                                        class="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs hover:bg-red-600 shadow transition-transform hover:scale-110">
                                        ✕
                                    </button>
                                </div>
                            </template>

                            <!-- Input file oculto -->
                            <input id="foto_firma" type="file" class="hidden" x-ref="fileInput" accept="image/*"
                                @click.stop @change="onFileSelect">
                        </div>
                        <x-input-error :messages="$errors->get('form.foto_firma')" class="mt-2" />
                        <p wire:loading wire:target="form.foto_firma" class="text-xs text-blue-600 mt-1">
                            <svg class="inline animate-spin h-3 w-3" fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                    stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor"
                                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                </path>
                            </svg>
                            Subiendo imagen...
                        </p>
                    </div>
                </div>

                <!-- Botón Guardar -->
                <div class="flex justify-end">
                    <x-primary-button type="submit" wire:loading.attr="disabled">
                        <svg wire:loading wire:target="guardar" class="animate-spin -ml-1 mr-2 h-4 w-4 text-white"
                            fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4">
                            </circle>
                            <path class="opacity-75" fill="currentColor"
                                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                            </path>
                        </svg>
                        {{ $firmaActual ? __('Actualizar Firma') : __('Guardar Firma') }}
                    </x-primary-button>
                </div>
            </form>
        </div>
    </div>
</div>