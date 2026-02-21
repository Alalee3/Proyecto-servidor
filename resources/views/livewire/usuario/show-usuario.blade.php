<div class="p-6 bg-white dark:bg-gray-800"> {{-- Contenedor principal del modal --}}
    <div class="md:grid md:grid-cols-1 md:gap-6">
        <div class="md:col-span-2">
            <h3 class="text-xl font-semibold leading-tight text-gray-900 dark:text-gray-100">
                Detalles del Usuario {{-- Título actualizado --}}
            </h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                Información detallada sobre el usuario. {{-- Descripción actualizada --}}
            </p>
        </div>

        <div class="mt-5 md:col-span-2 md:mt-0">
            <div class="shadow sm:rounded-md sm:overflow-hidden dark:bg-gray-800">
                {{-- Contenedor con scroll interno para contenido largo --}}
                <div class="px-4 py-5 bg-white sm:p-6 dark:bg-gray-800 max-h-[60vh] overflow-y-auto">

                    @if ($user)
                        {{-- Verificamos si el usuario fue cargado correctamente --}}
                        <div class="space-y-6"> {{-- Aumentamos el espacio entre secciones --}}

                            {{-- Sección de Nombre (grande) --}}
                            <div>
                                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Nombre Completo</dt>
                                <dd class="mt-1 text-2xl font-semibold text-gray-800 dark:text-gray-200">
                                    {{ $user->name }} {{ $user->apellido }} {{-- Muestra nombre y apellido juntos --}}
                                </dd>
                            </div>

                            <hr class="border-gray-200 dark:border-gray-700"> {{-- Separador visual --}}

                            {{-- Sección de Información General (en dos columnas) --}}
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4">
                                <div>
                                    <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Cédula</dt>
                                    <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100">
                                        {{ $user->cedula }}
                                    </dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Teléfono</dt>
                                    <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100">
                                        {{ $user->telefono ?? 'N/A' }}
                                    </dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Estatus</dt>
                                    <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100">
                                        <span
                                            class="{{ $user->estatus == 1 ? 'px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-600 dark:text-green-100' : 'px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:bg-red-600 dark:text-red-100' }}">
                                            {{ $user->estatus == 1 ? 'Activo' : 'Inactivo' }}
                                        </span>
                                    </dd>
                                </div>

                                {{-- Nuevos campos agregados --}}
                                <div>
                                    <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Correo Electrónico
                                    </dt>
                                    <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100">
                                        {{ $user->email ?? 'N/A' }}
                                    </dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">Fecha de Creación
                                    </dt>
                                    <dd class="mt-1 text-sm text-gray-900 dark:text-gray-100">
                                        {{ \Carbon\Carbon::parse($user->fecha_creacion)->format('d/m/Y H:i') }}
                                    </dd>
                                </div>
                                {{-- Fin de nuevos campos --}}

                            </div>

                        </div> {{-- Cierre de space-y-6 --}}
                    @else
                        {{-- Mensaje si el usuario no fue encontrado --}}
                        <p class="text-gray-500 dark:text-gray-400">No se ha encontrado la información del usuario.</p>
                    @endif
                </div>
            </div>
        </div>
    </div>

    {{-- Botón de Cerrar (fuera del contenedor con scroll para que siempre sea visible) --}}
    <div class="px-4 py-3 bg-gray-50 text-right sm:px-6 dark:bg-gray-800 rounded-b-lg">
        <button wire:click="closeModal"
            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            Cerrar
        </button>
    </div>
</div>

