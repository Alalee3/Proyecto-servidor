<div>
    <x-slot name="header">
        <h2 class="font-bold text-xl text-gray-800 dark:text-gray-500 leading-tight uppercase text-center">
            {{ __('Selección de Perfil') }}
        </h2>
    </x-slot>

    <div class="pt-8 pb-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="sogat-card planificacion-module p-10">

                <div class="text-center mb-10">
                    <h3 class="text-sm font-bold dark:text-gray-500 uppercase tracking-[0.2em]">
                        ¿Con qué rol deseas navegar hoy?
                    </h3>
                </div>

                <div class="grid grid-cols-1 gap-6">
                    @if(isset($misRoles) && count($misRoles) > 0)
                        @foreach ($misRoles as $miRol)
                            <div wire:click="seleccionarRol({{ $miRol->usu_cod_rol }})"
                                class="cursor-pointer group relative p-5 rounded-xl border-2 bg-gray-50 dark:bg-gray-900/50 border-gray-200 dark:border-gray-700 hover:border-[#265dcf] hover:shadow-md transition-all duration-300">

                                <div class="flex items-center justify-between">
                                    <span class="text-base font-extrabold text-[#265dcf] dark:text-blue-400 uppercase">
                                        {{ $miRol->rol_nombre }}
                                    </span>
                                    {{-- Sin check inicial en selección --}}
                                </div>
                            </div>
                        @endforeach
                    @endif
                </div>

                {{-- Footer removido --}}
            </div>
        </div>
    </div>
</div>