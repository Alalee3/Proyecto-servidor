<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Panel de Control') }}
        </h2>
    </x-slot>

    {{-- El padding py-12 y el contenedor max-w-7xl ahora son manejados por el layout app.blade.php --}}
    <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
        <div class="p-6 text-gray-900 dark:text-gray-100">
            <h3 class="text-lg font-medium">{{ __('¡Bienvenido/a al Sistema de Planificaciones Académicas!') }}</h3>
            <p class="mt-2">
                {{ __('Aqui podrá realizar sus planificaciones academicas!') }}
            </p>
        </div>
    </div>
</x-app-layout>
