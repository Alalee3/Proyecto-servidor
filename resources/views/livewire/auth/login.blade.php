<x-slot name="header">
    <!-- Logo Header (Sintillo) -->
    <div class="bg-white dark:bg-gray-800 px-8 py-2 flex items-center transition-colors duration-300">
        <div class="flex items-center w-full">
            <img src="{{ asset('img/logo_viejo-Photoroom.png') }}" alt="SOGAT Sintillo"
                class="w-full h-auto max-h-[100px] object-contain">
        </div>
    </div>

    <!-- Línea SOGAT (decoración) -->
    <div class="flex justify-center">
        <div class="sogat-hr !my-0"></div>
    </div>
</x-slot>

<div class="flex items-center justify-center pt-1 pb-4 -mt-8">
    <div class="max-w-md w-full space-y-4">
        <div class="text-center">
            <h2 class="text-2xl font-black text-black dark:text-white mb-2 uppercase tracking-[0.1em] leading-tight">
                Acceso al Sistema
            </h2>
            <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wider font-semibold">
                Credenciales de Emulación SOGAC
            </p>
        </div>

        <div class="sogat-card planificacion-module p-8 max-w-md mx-auto">
            @if ($errorMessage)
                <div class="mb-4">
                    <x-table.alert-message type="error" :message="$errorMessage" />
                </div>
            @endif

            <form wire:submit="login" class="space-y-6">
                <!-- Username -->
                <div>
                    <x-input-label for="username" value="Usuario" />
                    <x-text-input id="username" class="block mt-1 w-full" type="text" wire:model="username" required autofocus autocomplete="username" />
                    @error('username')
                        <span class="text-red-500 text-xs mt-1 block font-semibold">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Password -->
                <div>
                    <x-input-label for="password" value="Contraseña" />
                    <x-text-input id="password" class="block mt-1 w-full" type="password" wire:model="password" required autocomplete="current-password" />
                    @error('password')
                        <span class="text-red-500 text-xs mt-1 block font-semibold">{{ $message }}</span>
                    @enderror
                </div>

                <!-- Submit Button -->
                <div class="flex items-center justify-end pt-2">
                    <x-primary-button class="w-full justify-center py-3">
                        Ingresar
                    </x-primary-button>
                </div>
            </form>
        </div>
    </div>
</div>
