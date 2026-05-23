<div x-data="{ show: @entangle($attributes->wire('model')) }" x-show="show" x-on:keydown.escape.window="show = false"
    class="fixed inset-0 z-50 overflow-y-auto" style="display: none;" {{-- Oculto por defecto, Alpine.js lo mostrará --}}>
    {{-- Overlay (fondo oscuro semi-transparente) --}}
    <div x-show="show" x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0"
        x-transition:enter-end="opacity-100" x-transition:leave="ease-in duration-200"
        x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0"
        class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75 dark:bg-gray-900 dark:bg-opacity-75"
        aria-hidden="true" x-on:click="show = false"> {{-- Cierra el modal al hacer clic en el overlay --}}
    </div>

    {{-- Contenedor principal del modal (para centrar) --}}
    <div class="flex items-center justify-center min-h-screen px-4 py-6 sm:p-0">
        <div x-show="show" x-transition:enter="ease-out duration-300"
            x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100" x-transition:leave="ease-in duration-200"
            x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100"
            x-transition:leave-end="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full dark:bg-gray-800">
            {{ $slot }}
        </div>
    </div>
</div>
