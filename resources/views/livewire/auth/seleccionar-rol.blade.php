<div class="min-h-screen bg-gray-50 dark:bg-gray-900 py-12 px-4 sm:px-6 lg:px-8 flex items-center justify-center">
    <div class="max-w-md w-full space-y-8">
        <div class="sogat-card planificacion-module p-10">
            <div class="text-center mb-10">
                <h3 class="text-lg font-bold text-gray-800 dark:text-gray-100 mb-2 uppercase tracking-[0.2em]">
                    Selección de Rol
                </h3>
                <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-widest">
                    ¿Con qué rol deseas navegar hoy?
                </p>
            </div>

            @if(!$hayCalendarioActivo)
                <div class="mb-8 p-4 bg-yellow-50 dark:bg-yellow-900/30 border-l-4 border-yellow-400 rounded-r-lg">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                        <span class="text-xs font-bold text-yellow-800 dark:text-yellow-200 uppercase tracking-tight">
                            Sistema Inactivo: No hay calendario académico configurado. Solo los administradores pueden ingresar.
                        </span>
                    </div>
                </div>
            @endif

            <x-table.alert-message type="error" :message="session('error')" />

            <div class="grid grid-cols-1 gap-4">
                @foreach ($misRoles as $miRol)
                    @php
                        $isRestricted = !$hayCalendarioActivo && $miRol->usu_cod_rol != 3;
                    @endphp
                    <div 
                        @if(!$isRestricted) wire:click="seleccionarRol({{ $miRol->usu_cod_rol }})" @endif
                        class="{{ $isRestricted ? 'opacity-40 cursor-not-allowed grayscale' : 'cursor-pointer hover:border-sogat-red hover:shadow-md' }} group relative p-5 rounded-xl border-2 bg-gray-50 dark:bg-gray-900/50 border-gray-200 dark:border-gray-700 transition-all duration-300"
                    >
                        <div class="flex items-center justify-between">
                            <span class="text-sm font-extrabold text-black dark:text-white uppercase">
                                {{ $miRol->rol_nombre }}
                            </span>
                            @if(!$isRestricted)
                                <svg class="w-5 h-5 text-gray-300 group-hover:text-sogat-red transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                </svg>
                            @else
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                </svg>
                            @endif
                        </div>
                    </div>
                @endforeach
            </div>

            <div class="mt-8 pt-6 border-t border-gray-100 dark:border-gray-800 text-center">
                <a href="{{ route('login') }}" class="text-[10px] font-bold text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 uppercase tracking-widest transition-colors">
                    Volver al inicio de sesión
                </a>
            </div>
        </div>
    </div>
</div>