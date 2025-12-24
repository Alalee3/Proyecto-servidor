<!-- resources/views/components/confirm-action-modal.blade.php -->
@props([
    'show' => false,
    'title' => 'Confirmar acción',
    'message' => '¿Estás seguro de que deseas realizar esta acción?',
    'cancelText' => 'Cancelar',
    'confirmText' => 'Confirmar',
    'cancelMethod' => '$set("actionId", null)',
    'confirmMethod' => 'executeAction',
    'actionType' => 'delete' // 'delete' (rojo) o 'restore' (verde)
])

@if($show)
    <div class="fixed inset-0 flex items-center justify-center z-50 bg-black/10 bg-opacity-50">
        <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg w-full max-w-md">
            <!-- Icono de advertencia/confirmación -->
            <div class="flex justify-center mb-4">
                @if($actionType === 'delete')
                    <svg class="w-10 h-10 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                @else
                    <svg class="w-10 h-10 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                @endif
            </div>
            
            <h2 class="text-lg font-semibold text-center text-gray-800 dark:text-gray-200">
                {{ $title }}
            </h2>
            
            <p class="mt-2 text-center text-gray-600 dark:text-gray-400">
                {{ $message }}
            </p>
            
            <div class="mt-6 flex justify-center space-x-4">
                <button
                    wire:click="{{ $cancelMethod }}"
                    class="px-6 py-2 bg-gray-300 dark:bg-gray-700 text-gray-800 dark:text-gray-200 rounded-lg hover:bg-gray-400 dark:hover:bg-gray-600 transition duration-200">
                    {{ $cancelText }}
                </button>
                
                <button 
                    wire:click="{{ $confirmMethod }}"
                    @class([
                        'px-6 py-2 text-white rounded-lg transition duration-200',
                        'bg-red-600 hover:bg-red-700 focus:ring-2 focus:ring-red-500 focus:ring-opacity-50' => $actionType === 'delete',
                        'bg-green-600 hover:bg-green-700 focus:ring-2 focus:ring-green-500 focus:ring-opacity-50' => $actionType === 'restore',
                    ])>
                    {{ $confirmText }}
                </button>
            </div>
        </div>
    </div>
@endif