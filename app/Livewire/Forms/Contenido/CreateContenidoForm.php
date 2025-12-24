<?php

namespace App\Livewire\Forms\Contenido;

use Illuminate\Validation\Rule;
use Livewire\Form;

class CreateContenidoForm extends Form
{
    public $id_unidad_curricular = '';
    public $titulo_contenido = '';
    public $descripcion_contenido = '';
    public $corte_contenido = '';

    protected function rules()
    {
        return [
            'id_unidad_curricular' => 'required|exists:unidad_curricular,id_unidad_curricular',
            'titulo_contenido' => [
                'required',
                'string',
                'min:3',
                'max:255',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\s0-9\.]+$/u', // Letras, números, espacios y puntos
                Rule::unique('contenido', 'titulo_contenido')
            ],
            'descripcion_contenido' => 'nullable|string|max:500',
            'corte_contenido' => 'required|in:1,2,3,4',
        ];
    }

    protected function messages()
    {
        return [
            'id_unidad_curricular.required' => 'Debe seleccionar una unidad curricular.',
            'id_unidad_curricular.exists' => 'La unidad curricular seleccionada no es válida.',
            'titulo_contenido.required' => 'El título del contenido es obligatorio.',
            'titulo_contenido.string' => 'El título debe ser texto.',
            'titulo_contenido.min' => 'El título debe tener al menos 3 caracteres.',
            'titulo_contenido.max' => 'El título no debe exceder los 255 caracteres.',
            'titulo_contenido.regex' => 'El título contiene caracteres no permitidos.',
            'titulo_contenido.unique' => 'Ya existe un contenido con este título.',
            'descripcion_contenido.string' => 'La descripción debe ser texto.',
            'descripcion_contenido.max' => 'La descripción no debe exceder los 500 caracteres.',
            'corte_contenido.required' => 'Debe seleccionar un corte.',
            'corte_contenido.in' => 'El corte seleccionado no es válido.',
        ];
    }

    public function values()
    {
        return [
            'id_unidad_curricular' => $this->id_unidad_curricular,
            'titulo_contenido' => $this->titulo_contenido,
            'descripcion_contenido' => $this->descripcion_contenido,
            'corte_contenido' => $this->corte_contenido,
        ];
    }
}
