<div>
    @if ($mostrar)
        <div wire:key="notification-{{ $notificationId ?? rand() }}" {{-- Se añade wire:key --}}
            class="fixed top-4 right-4 z-50"
            x-data="{ mostrar: @entangle('mostrar'), timeoutId: null }"
            x-init="timeoutId = setTimeout(() => mostrar = false, 2500)" {{-- x-init simplificado --}}
            x-show="mostrar"
            x-transition:enter="transition ease-out duration-300"
            x-transition:enter-start="opacity-0 transform translate-x-8"
            x-transition:enter-end="opacity-100 transform translate-x-0"
            x-transition:leave="transition ease-in duration-200"
            x-transition:leave-start="opacity-100 transform translate-x-0"
            x-transition:leave-end="opacity-0 transform translate-x-8">
            <div class="bg-{{ $color }}-200 border-{{ $color }}-400 text-{{ $color }}-700 px-4 py-3 rounded relative"
                role="alert">
                <strong class="font-bold">{{ ucfirst($tipo) }}!</strong>

                <span class="block sm:inline">{{ $mensaje }}</span>
                <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                    <svg fill="currentColor" viewBox="0 0 20 20" class="h-6 w-6 text-{{ $tipo }}-500"
                        @click="mostrar = false; clearTimeout(timeoutId)">
                        <path fill-rule="evenodd"
                            d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                            clip-rule="evenodd"></path>
                    </svg>
                </span>
            </div>
        </div>
    @endif
</div>
