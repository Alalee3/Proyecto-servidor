<?php

namespace App\Livewire\Forms\Firma;

use Livewire\Form;

class UpdateFirmaForm extends Form
{
    public $id_firma;

    public $foto_firma = null;

    public $foto_preview = null;

    protected function rules()
    {
        return [
            'foto_firma' => 'nullable|image|max:10240',
        ];
    }

    protected function messages()
    {
        return [
            'foto_firma.image' => 'El archivo debe ser una imagen válida (JPEG, PNG, GIF, WebP).',
            'foto_firma.max' => 'La imagen no debe superar los 10MB.',
        ];
    }

    public function setForm($firma)
    {
        $this->id_firma = $firma->id_firma;
        $this->foto_preview = $firma->foto_base64;
    }
}
