<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Livewire\Attributes\Validate;

class NotasCalendarioForm extends Form
{
    public $notas = [];

    #[Validate('required|string|max:500', message: [
        'required' => 'La nota no puede estar vacía.',
        'max' => 'La nota no puede exceder los 500 caracteres.'
    ])]
    public $nuevaNota = '';

    public function setNotas($notasIniciales)
    {
        $this->notas = is_array($notasIniciales) ? $notasIniciales : [];
    }

    public function agregarNota()
    {
        $this->validate();

        $this->notas[] = $this->nuevaNota;
        $this->nuevaNota = '';
    }

    public function eliminarNota($index)
    {
        if (isset($this->notas[$index])) {
            unset($this->notas[$index]);
            $this->notas = array_values($this->notas);
        }
    }
}
