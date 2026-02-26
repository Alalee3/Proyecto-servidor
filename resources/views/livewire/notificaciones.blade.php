<div>
    @if ($mostrar)
        @php
            $isSuccess = in_array($tipo, ['success', 'exitoso', 'exito']);
            $bgColor = $isSuccess ? 'bg-green-50' : 'bg-red-50';
            $textColor = $isSuccess ? 'text-green-800' : 'text-red-800';
            $borderColor = $isSuccess ? 'border-green-200' : 'border-red-200';
            $title = $isSuccess ? '¡ÉXITO!' : '¡ERROR!';
        @endphp
        <div wire:key="notification-{{ $notificationId ?? rand() }}" class="fixed top-4 right-4 z-[9999] w-80"
            x-data="{ show: @entangle('mostrar'), timeoutId: null }"
            x-init="timeoutId = setTimeout(() => show = false, 4000)" x-show="show"
            x-transition:enter="transition ease-out duration-300"
            x-transition:enter-start="opacity-0 transform translate-x-8"
            x-transition:enter-end="opacity-100 transform translate-x-0"
            x-transition:leave="transition ease-in duration-200"
            x-transition:leave-start="opacity-100 transform translate-x-0"
            x-transition:leave-end="opacity-0 transform translate-x-8">

            <div class="p-4 rounded-lg shadow-lg border {{ $bgColor }} {{ $textColor }} {{ $borderColor }} dark:bg-gray-800 dark:border-gray-700"
                role="alert">
                <div class="flex items-start">
                    <div class="flex-1">
                        <strong class="block font-bold">{{ $title }}</strong>
                        <span class="block mt-1 text-xs">{{ $mensaje }}</span>
                    </div>
                    <button type="button"
                        class="ml-auto -mx-1.5 -my-1.5 p-1.5 inline-flex items-center justify-center h-8 w-8 text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 dark:hover:text-white"
                        @click="show = false; clearTimeout(timeoutId)">
                        <svg class="w-3 h-3" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    @endif
</div>