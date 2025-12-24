<div>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-500 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Crear Nuevo Usuario') }}
        </h2>
    </x-slot>

    <div class="p-6 bg-white dark:bg-gray-800 shadow-md rounded-lg">
        <form wire:submit.prevent="save">
            <div class="space-y-4">

                @if (session()->has('message'))
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4
                                 dark:bg-green-700 dark:border-green-800 dark:text-green-100"
                        role="alert">
                        <span class="block sm:inline">{{ session('message') }}</span>
                    </div>
                @endif

                @if (session()->has('error'))
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4
                                 dark:bg-red-700 dark:border-red-800 dark:text-red-100"
                        role="alert">
                        <span class="block sm:inline">{{ session('error') }}</span>
                    </div>
                @endif

                <div class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
                    {{-- Nombre --}}
                    <div>
                        <label for="name" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Nombre:</label>
                        <input type="text" id="name" wire:model.live.debounce.250ms="form.name"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.name')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>

                    {{-- Apellido --}}
                    <div>
                        <label for="apellido" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Apellido:</label>
                        <input type="text" id="apellido" wire:model.live.debounce.250ms="form.apellido"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.apellido')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>

                    {{-- Cédula --}}
                    <div>
                        <label for="cedula" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Cédula:</label>
                        <input type="text" id="cedula" wire:model.live.debounce.250ms="form.cedula"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.cedula')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>

                    {{-- Email --}}
                    <div>
                        <label for="email" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Correo Electrónico:</label>
                        <input type="email" id="email" wire:model.live.debounce.250ms="form.email"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.email')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>

                    {{-- Contraseña --}}
                    <div>
                        <label for="password" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Contraseña:</label>
                        <input type="password" id="password" wire:model.live.debounce.250ms="form.password"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.password')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>

                    {{-- Confirmar Contraseña --}}
                    <div>
                        <label for="password_confirmation" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Confirmar Contraseña:</label>
                        <input type="password" id="password_confirmation" wire:model.live.debounce.250ms="form.password_confirmation"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                    </div>

                    {{-- Teléfono --}}
                    <div>
                        <label for="telefono" class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">Teléfono:</label>
                        <input type="text" id="telefono" wire:model.live.debounce.250ms="form.telefono"
                            class="shadow appearance-none border rounded w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                               dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        @error('form.telefono')
                            <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                        @enderror
                    </div>
                </div>

                {{-- Selección de Roles --}}
                <div class="mb-6">
                    <h3 class="text-lg font-bold text-gray-800 dark:text-gray-200 mb-3">Asignar Roles</h3>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                        @forelse($allRoles as $role)
                            <div class="flex items-center">
                                <input id="role_{{ $role->rol_id }}" name="roles[]" type="checkbox"
                                    class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded dark:bg-gray-700 dark:border-gray-600"
                                    wire:model.live="form.selectedRoles" value="{{ $role->rol_id }}">
                                <label for="role_{{ $role->rol_id }}" class="ml-2 text-sm font-medium text-gray-700 dark:text-gray-300">
                                    {{ $role->acceso }}
                                </label>
                            </div>
                        @empty
                            <p class="text-gray-500 dark:text-gray-400 col-span-full">No hay roles disponibles</p>
                        @endforelse
                    </div>

                    @error('form.selectedRoles')
                        <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                    @enderror
                    @error('form.selectedRoles.*')
                        <span class="text-red-500 text-xs italic dark:text-red-400">{{ $message }}</span>
                    @enderror
                </div>

                {{-- Botón de Enviar --}}
                <div class="flex justify-end">
                    <button type="submit"
                        class="inline-flex items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed">
                        CREAR USUARIO
                    </button>
                </div>

            </div>
        </form>
    </div>
</div>
