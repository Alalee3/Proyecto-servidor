@props([
    'options',
    'valueField',
    'textField',
    'wireModel' => null, // Hacemos wireModel opcional
    'label' => null,
    'required' => false,
    'placeholder' => '-- Seleccione --',
    'errorField' => null,
    'disabled' => false,
    'extraClasses' => '',
    'labelClasses' => '',
    'errorClasses' => '',
    // Nuevo: Extraer el wire:model de los atributos
    'wireModelFromAttributes' => $attributes->whereStartsWith('wire:model')->first(),
])

@php
    // Obtenemos el wireModel (usando prop o atributo)
    $finalWireModel = $wireModel ?? ($wireModelFromAttributes ?? '');
    $labelValue = $label ?? $attributes->get('label');
    $finalErrorField = $errorField ?? last(explode('.', $finalWireModel));

    // Clases condicionales
    $selectClasses = Arr::toCssClasses([
        'block w-full py-2 px-3 border rounded-md shadow-sm',
        'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100',
        'border-gray-300 dark:border-gray-700',
        'focus:outline-none focus:ring-indigo-500 focus:border-indigo-500',
        'mt-1' => !is_null($labelValue),
        $extraClasses,
    ]);
@endphp

<div>
    @unless (is_null($labelValue))
        <label for="{{ $finalWireModel ?: Str::random(8) }}"
            class="block text-sm font-medium text-gray-700 dark:text-gray-100 {{ $labelClasses }}">
            {{ $labelValue }}
            @if ($required)
                <span class="text-red-500">*</span>
            @endif
        </label>
    @endunless

    <select id="{{ $finalWireModel ?: Str::random(8) }}" name="{{ $name ?? $finalWireModel }}"
        @if ($finalWireModel) wire:model.live.debounce.250ms="{{ $finalWireModel }}" @endif
        @required($required) @disabled($disabled) {{ $attributes->class($selectClasses) }}>
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
