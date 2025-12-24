<?php

namespace App\Livewire\Forms\Tema;

use Illuminate\Validation\Rule;
use Livewire\Form;

class UpdateTemaForm extends Form
{
    public $id = '';
    public $id_contenido = '';
    public $titulo_tema = '';
    public $descripcion_tema = '';

    protected function rules()
    {
        return [
            'id_contenido' => 'required|exists:contenido,id_contenido',
            'titulo_tema' => [
                'required',
                'string',
                'min:3',
                'max:255',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\s0-9\.]+$/u',
                Rule::unique('tema', 'titulo_tema')->ignore($this->id, 'id_tema')
            ],
            'descripcion_tema' => 'nullable|string|max:500',
        ];
    }

    protected function messages()
    {
        return [
            'id_contenido.required' => 'Debe seleccionar un contenido.',
            'id_contenido.exists' => 'El contenido seleccionado no es válido.',
            'titulo_tema.required' => 'El título del tema es obligatorio.',
            'titulo_tema.string' => 'El título debe ser texto.',
            'titulo_tema.min' => 'El título debe tener al menos 3 caracteres.',
            'titulo_tema.max' => 'El título no debe exceder los 255 caracteres.',
            'titulo_tema.regex' => 'El título contiene caracteres no permitidos.',
            'titulo_tema.unique' => 'Ya existe un tema con este título.',
            'descripcion_tema.string' => 'La descripción debe ser texto.',
            'descripcion_tema.max' => 'La descripción no debe exceder los 500 caracteres.',
        ];
    }

    public function setTema($tema)
    {
        $this->id = $tema->id;
        $this->id_contenido = $tema->id_contenido;
        $this->titulo_tema = $tema->titulo_tema;
        $this->descripcion_tema = $tema->descripcion_tema;
    }

    public function values()
    {
        return [
            'id_contenido' => $this->id_contenido,
            'titulo_tema' => $this->titulo_tema,
            'descripcion_tema' => $this->descripcion_tema,
        ];
    }
}
