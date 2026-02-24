<div>
    <!-- Header de la página -->
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-center text-gray-800 dark:text-gray-500 leading-tight uppercase">
            {{ __('Detalles de la Auditoría') }}
        </h2>
    </x-slot>

    <!-- Contenedor principal -->
    <div class="pt-2 pb-6">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            <div class="sogat-card">

                @if ($bitacora)
                    <!-- Grid de información general -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
                        <div>
                            <x-input-label value="Fecha del Movimiento:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold border-b dark:border-gray-700 pb-1">
                                {{ \Carbon\Carbon::parse($bitacora->fecha)->format('d/m/Y H:i:s') }}
                            </p>
                        </div>

                        <div>
                            <x-input-label value="Usuario Autor:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold overflow-wrap break-words border-b dark:border-gray-700 pb-1">
                                {{ $bitacora->usuario_nombre ?? 'Sistema Automático' }}
                                {!! $bitacora->usuario_correo ? '<span class="text-xs text-gray-500 font-normal">(' . $bitacora->usuario_correo . ')</span>' : '' !!}
                            </p>
                        </div>

                        <div>
                            <x-input-label value="Acción Realizada:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold border-b dark:border-gray-700 pb-1">
                                @php
                                    $color = match ($bitacora->accion) {
                                        'CREAR' => 'text-green-800 bg-green-100 dark:bg-green-900 dark:text-green-300',
                                        'MODIFICAR' => 'text-blue-800 bg-blue-100 dark:bg-blue-900 dark:text-blue-300',
                                        'ELIMINAR' => 'text-red-800 bg-red-100 dark:bg-red-900 dark:text-red-300',
                                        'LOGIN' => 'text-purple-800 bg-purple-100 dark:bg-purple-900 dark:text-purple-300',
                                        'LOGOUT' => 'text-yellow-800 bg-yellow-100 dark:bg-yellow-900 dark:text-yellow-300',
                                        default => 'text-gray-800 bg-gray-100 dark:bg-gray-900 dark:text-gray-300',
                                    };
                                @endphp
                                <span class="{{ $color }} text-sm font-bold px-2.5 py-0.5 rounded uppercase">
                                    {{ $bitacora->accion }}
                                </span>
                            </p>
                        </div>

                        <div>
                            <x-input-label value="Tabla Afectada:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold border-b dark:border-gray-700 pb-1">
                                {{ $bitacora->tabla ?? '---' }}
                            </p>
                        </div>

                        <div>
                            <x-input-label value="ID Registro Afectado:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold border-b dark:border-gray-700 pb-1">
                                {{ $bitacora->registro_id ?? '---' }}
                            </p>
                        </div>

                        <div>
                            <x-input-label value="Dirección IP de Origen:" />
                            <p
                                class="text-gray-700 dark:text-gray-300 text-lg font-semibold font-mono border-b dark:border-gray-700 pb-1">
                                {{ $bitacora->ip ?? 'Desconocida' }}
                            </p>
                        </div>
                    </div>

                    <!-- Detalles JSON de cambios -->
                    @if($bitacora->anteriores || $bitacora->nuevos)
                        <div class="mt-8 border-t dark:border-gray-700 pt-6">
                            <h3 class="text-sm font-bold text-gray-500 dark:text-gray-400 uppercase tracking-widest mb-4">
                                Detalles del Movimiento de Datos</h3>

                            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

                                <!-- Valores Anteriores -->
                                <div>
                                    <div
                                        class="bg-red-50 dark:bg-red-900/20 border-t-4 border-red-500 dark:border-red-700 rounded-lg p-4 h-full shadow-inner">
                                        <h4 class="text-red-800 dark:text-red-400 font-bold mb-3 flex items-center gap-2">
                                            <span class="material-icons text-sm">remove_circle_outline</span>
                                            Valores Anteriores (Eliminados/Borrados)
                                        </h4>
                                        <pre
                                            class="bg-white dark:bg-gray-900 rounded p-4 overflow-x-auto text-xs font-mono text-gray-800 dark:text-gray-300 border border-red-100 dark:border-red-900/50 shadow-sm">
                                @if($bitacora->anteriores)
                                    @php
                                        $datosAnteriores = json_decode($bitacora->anteriores, true) ?? $bitacora->anteriores;
                                        echo json_encode($datosAnteriores, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                                    @endphp
                                @else
                                    <span class="text-gray-400 italic">No aplicable o nulo</span>
                                @endif
                                </pre>
                                    </div>
                                </div>

                                <!-- Valores Nuevos -->
                                <div>
                                    <div
                                        class="bg-green-50 dark:bg-green-900/20 border-t-4 border-green-500 dark:border-green-700 rounded-lg p-4 h-full shadow-inner">
                                        <h4 class="text-green-800 dark:text-green-400 font-bold mb-3 flex items-center gap-2">
                                            <span class="material-icons text-sm">add_circle_outline</span>
                                            Valores Nuevos (Agregados/Actualizados)
                                        </h4>
                                        <pre
                                            class="bg-white dark:bg-gray-900 rounded p-4 overflow-x-auto text-xs font-mono text-gray-800 dark:text-gray-300 border border-green-100 dark:border-green-900/50 shadow-sm">
                                @if($bitacora->nuevos)
                                    @php
                                        $datosNuevos = json_decode($bitacora->nuevos, true) ?? $bitacora->nuevos;
                                        echo json_encode($datosNuevos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                                    @endphp
                                @else
                                    <span class="text-gray-400 italic">No aplicable o nulo</span>
                                @endif
                                </pre>
                                    </div>
                                </div>

                            </div>
                        </div>
                    @endif

                @else
                    <p class="text-gray-500 dark:text-gray-400">No se ha encontrado el registro de Bitácora...</p>
                @endif

                <!-- Botón Volver -->
                <div class="flex justify-end mt-8 border-t dark:border-gray-700 pt-6">
                    <x-danger-button type="button" wire:click="cerrar">
                        <link rel="stylesheet"
                            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=arrow_back" />
                        <span class="material-symbols-outlined mr-2">arrow_back</span>
                        {{ __('Volver') }}
                    </x-danger-button>
                </div>

            </div>
        </div>
    </div>
</div>