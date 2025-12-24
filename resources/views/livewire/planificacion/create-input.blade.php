<div class="p-4 dark:bg-gray-800 bg-gray-200">
    <h2 class="text-xl font-semibold text-gray-900 dark:text-gray-100 mb-4">
        Crear {{ Str::lower(Str::after($inputLabel, 'Nuevo ')) }}
    </h2>

    <form wire:submit.prevent="save">
        <div class="mb-4">
            <label for="inputValue" class="block text-sm font-medium text-gray-700 dark:text-gray-200">
                {{ $inputLabel }}
                @if ($isRequired)
                    {{-- ¡Aquí está el cambio! --}}
                    <span class="text-red-500">*</span>
                @endif
            </label>
            <input type="text" id="inputValue" wire:model.live.debounce.300ms="inputValue"
                placeholder="{{ $placeholder }}"
                class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-gray-700 dark:border-gray-600 dark:text-gray-100">

            @error('inputValue')
                <span class="text-red-500 text-sm mt-1">{{ $message }}</span>
            @enderror
        </div>

        <div class="flex justify-end mt-6 space-x-2">
            {{-- Botón Cancelar --}}
            <button type="button" wire:click="closeModal"
                class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-400 dark:bg-gray-600 dark:text-gray-100 dark:hover:bg-gray-500">
                Cerrar
            </button>

            {{-- Botón Guardar --}}
            <button type="submit"
                class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                Guardar
            </button>
        </div>
    </form>
</div>
