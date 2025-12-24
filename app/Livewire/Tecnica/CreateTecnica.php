<?php

namespace App\Livewire\Tecnica;

use Livewire\Component;
use App\Livewire\Forms\Tecnica\CreateTecnicaForm;
use App\Repositories\Tecnica\TecnicaCreateRepo;
use Exception;

class CreateTecnica extends Component
{
    public CreateTecnicaForm $form;
    protected $tecnicasRepository;

    public function __construct()
    {
        $this->tecnicasRepository = new TecnicaCreateRepo();
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->tecnicasRepository->crear($this->form->all());
            $this->reset('form.nombre');
            session()->flash('message', 'Técnica de evaluación creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear la técnica de evaluación. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.tecnica.create-tecnica');
    }
}
