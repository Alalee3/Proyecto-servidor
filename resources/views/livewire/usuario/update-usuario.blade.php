<div class="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-xl">
    <h2 class=" text-xl font-bold mb-4 text-gray-800 dark:text-gray-200">
        Editar Roles para: <span class="text-blue-600 dark:text-blue-400">{{ $userName }}</span>
    </h2>

    @if (session()->has('error'))
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4 dark:bg-red-900 dark:border-red-700 dark:text-red-300"
            role="alert">
            <span class="block sm:inline">{{ session('error') }}</span>
        </div>
    @endif
    @if (session()->has('message'))
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 dark:bg-green-900 dark:border-green-700 dark:text-green-300"
            role="alert">
            <span class="block sm:inline">{{ session('message') }}</span>
        </div>
    @endif

    <form wire:submit.prevent="saveRoles">
        {{-- Campo oculto para el ID del usuario --}}
        <input type="hidden" wire:model="form.userId">

        <div class="mb-4">
            <label class="block text-gray-700 text-sm font-bold mb-2 dark:text-gray-300">
                Roles Disponibles:
            </label>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                @forelse ($availableRoles as $role)
                    <div class="flex items-center">
                        <input type="checkbox" wire:model="form.selectedRoleIds" id="role_{{ $role->rol_id }}"
                            value="{{ $role->rol_id }}"
                            class="form-checkbox h-5 w-5 text-indigo-600 transition duration-150 ease-in-out rounded-sm dark:bg-gray-700 border-gray-300 dark:border-gray-600 shadow-sm focus:ring-indigo-500 dark:focus:ring-indigo-600 dark:focus:ring-offset-gray-800">
                        <label for="role_{{ $role->rol_id }}"
                            class="ml-2 text-gray-700 dark:text-gray-400">{{ $role->acceso }}</label>
                    </div>
                @empty
                    <p class="text-gray-500 dark:text-gray-400">No hay roles disponibles.</p>
                @endforelse
            </div>
            {{-- Mensajes de error de validación --}}
            @error('form.selectedRoleIds')
                <span class="text-red-500 text-xs mt-1 dark:text-red-400">{{ $message }}</span>
            @enderror
            @error('form.selectedRoleIds.*')
                <span class="text-red-500 text-xs mt-1 dark:text-red-400">{{ $message }}</span>
            @enderror
        </div>

        <div class="flex justify-end items-center mt-6">
            <button type="button"
                class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline transition duration-150 ease-in-out dark:bg-gray-600 dark:hover:bg-gray-700 dark:text-gray-200"
                onclick="Livewire.dispatch('closeModal')">
                Cancelar
            </button>
            <button type="submit"
                class="ml-3 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline transition duration-150 ease-in-out dark:bg-blue-600 dark:hover:bg-blue-700"
                wire:loading.attr="disabled" wire:target="saveRoles">
                Guardar Roles
            </button>
        </div>
    </form>
</div>
