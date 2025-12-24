<?php

namespace App\Livewire\IndicadorLogro;

use App\Livewire\Forms\IndicadorLogro\CreateIndicadorLogroForm;
use App\Repositories\IndicadorLogro\IndicadorLogroCreateRepo;
use Livewire\Component;

class CreateIndicadorLogro extends Component
{
    protected $indicadorRepo;
    public CreateIndicadorLogroForm $form;

    public function __construct()
    {
        $this->indicadorRepo = new IndicadorLogroCreateRepo();
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->indicadorRepo->crear($this->form->values());

            $this->reset('form.nombre_indicador_logro');
            session()->flash('message', 'Indicador de logro creado correctamente.');
        } catch (\Exception $e) {
            session()->flash('error', 'Error al intentar guardar el indicador.');
        }
    }

    public function render()
    {
        return view('livewire.pages.indicador-logro.create-indicador-logro');
    }
}
