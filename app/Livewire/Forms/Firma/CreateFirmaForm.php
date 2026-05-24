<?php

namespace App\Livewire\Forms\Firma;

use Livewire\Form;

class CreateFirmaForm extends Form
{
    public $foto_firma = null;

    protected function rules()
    {
        return [
            'foto_firma' => 'required|image|max:10240',
        ];
    }

    protected function messages()
    {
        return [
            'foto_firma.required' => 'Debe seleccionar una imagen de firma.',
            'foto_firma.image' => 'El archivo debe ser una imagen válida (JPEG, PNG, GIF, WebP).',
            'foto_firma.max' => 'La imagen no debe superar los 10MB.',
        ];
    }
}
