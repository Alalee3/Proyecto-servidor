@props([
    'selectedUnidadCodigo', // El código de la unidad curricular seleccionada
    'unidadesCurriculares', // La colección completa de unidades curriculares
])

@php
    // Buscar la unidad curricular seleccionada en la colección
    $unidadSeleccionada = $unidadesCurriculares->firstWhere('codigo', $selectedUnidadCodigo);
@endphp

{{-- Mostrar los detalles solo si una unidad curricular ha sido seleccionada y encontrada --}}
@if ($unidadSeleccionada)
    <div class="mt-2 p-4 bg-gray-50 border border-gray-200 rounded-lg shadow-sm dark:border-gray-900 dark:bg-gray-800">
        <h4 class="text-lg font-semibold text-gray-800 mb-3 dark:text-gray-100">Detalles de la Unidad Curricular: <span
                class="text-gray-800 dark:text-gray-100">{{ $unidadSeleccionada->nombre }}</span></h4>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-3 text-sm text-gray-700 dark:text-gray-100">
            <div>
                <p><strong class="font-medium">Nombre:</strong> {{ $unidadSeleccionada->nombre }}</p>
                {{-- Nombre antes del código --}}
                <p><strong class="font-medium">Código:</strong> {{ $unidadSeleccionada->codigo }}</p>
                <p><strong class="font-medium">PNF:</strong> {{ $unidadSeleccionada->pnf_nombre }}</p>
                <p><strong class="font-medium">Trayecto:</strong>
                    @if ($unidadSeleccionada->trayecto == 0)
                        {{-- Condición para "Inicial" --}}
                        Inicial
                    @else
                        {{ $unidadSeleccionada->trayecto }}
                    @endif
                </p>
                <p><strong class="font-medium">Tipo:</strong>
                    {{-- CAMBIO: Usamos '==' en lugar de '===' para comparar el valor numérico (que es un string) --}}
                    @if ($unidadSeleccionada->tipo == 1)
                        Semestral
                    @elseif ($unidadSeleccionada->tipo == 2)
                        Anual
                    @else
                        {{ $unidadSeleccionada->tipo }}
                    @endif
                </p>
            </div>
            <div>
                <p><strong class="font-medium">Unidades de Crédito:</strong> {{ $unidadSeleccionada->unidades_credito }}
                </p>
                <p><strong class="font-medium">Horas Semanales:</strong> {{ $unidadSeleccionada->horas_semanales }}</p>
            </div>
        </div>

        <div class="mt-3">
            <strong class="font-medium text-gray-800 dark:text-gray-100">Descripción:</strong>
            <p class="text-gray-800 dark:text-gray-100 leading-relaxed">{{ $unidadSeleccionada->descripcion }}</p>

            <strong class="font-medium text-gray-800 dark:text-gray-100">Propósito:</strong>
            <p class="text-gray-800 dark:text-gray-100 leading-relaxed">{{ $unidadSeleccionada->proposito }}</p>
        </div>
    </div>
@endif
