@props([
'options', // Colección de opciones (ej. de DB)
'valueField', // Nombre del campo ID en tus opciones (ej. 'lapso_id')
'textField', // Nombre del campo de texto a mostrar (ej. 'lapso')
'wireModel', // La propiedad de Livewire a la que se vinculará (ej. 'form.lapso_id')
'label', // Texto del label
'required' => false, // Si es requerido
'placeholder' => '-- Seleccione --', // Texto de la opción por defecto
'errorField' => null, // Nombre del campo para mostrar el error (si es diferente al wireModel)
'disabled' => false, // Si el select debe estar deshabilitado
'extraClasses' => '', // Clases CSS adicionales para el select
'labelClasses' => '', // Clases CSS adicionales para el label
'errorClasses' => '', // Clases CSS adicionales para el mensaje de error
])

{{-- Determina el campo de error real --}}
@php
$finalErrorField = $errorField ?? last(explode('.', $wireModel));
@endphp

<div>
    <label for="{{ $wireModel }}"
        class="block text-sm font-medium text-gray-700 dark:text-gray-100 {{ $labelClasses }}">
        {{ $label }}
        @if ($required)
        <span class="text-red-500">*</span>
        @endif
    </label>
    <select id="{{ $wireModel }}" name="{{ $wireModel }}" wire:model.live.debounce.250ms="{{ $wireModel }}"
        @if ($required) required @endif @if ($disabled) disabled @endif
        {{ $attributes->class([
            // Permite pasar clases adicionales desde el padre
            'mt-1 block w-full py-2 px-3 border border-gray-300 bg-white dark:border-gray-900 dark:bg-gray-800 dark:text-gray-100 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm',
            $extraClasses,
        ]) }}>
        <option value="">{{ $placeholder }}</option>
        @foreach ($options as $option)
        <option value="{{ $option->{$valueField} }}">
            {{ $option->{$textField} }}
        </option>
        @endforeach
    </select>

    @error($finalErrorField)
    <p class="mt-2 text-sm text-red-600 {{ $errorClasses }}">{{ $message }}</p>
    @enderror
</div>