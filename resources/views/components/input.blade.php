@props([
    'label' => null,
    'name' => null, // Asegúrate de que esta línea esté presente
    'type' => 'text',
    'placeholder' => '',
    'required' => false,
    'errorField' => null, // Permite especificar el campo de error de Livewire
])

{{-- Si errorField no está definido, usa name como fallback --}}
@php
    $finalErrorField = $errorField ?? $name;
@endphp

<div {{ $attributes->merge(['class' => 'mb-4']) }}>
    @if ($label)
        <label for="{{ $name }}" class="block font-bold text-sm text-gray-900 dark:text-white uppercase">
            {{ $label }}
            @if ($required)
                <span class="text-red-500">*</span>
            @endif
        </label>
    @endif
    <input type="{{ $type }}" id="{{ $name }}" name="{{ $name }}" placeholder="{{ $placeholder }}"
        class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm dark:bg-gray-700 dark:border-gray-600 dark:text-gray-100" />
    @error($finalErrorField)
        <span class="text-red-600 text-sm">{{ $message }}</span>
    @enderror
</div>
