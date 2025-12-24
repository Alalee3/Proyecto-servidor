<?php

namespace App\Livewire\Recurso;

use App\Livewire\Forms\Recurso\CreateRecursoForm;
use Livewire\Component;
use App\Repositories\Recurso\RecursoCreateRepo;
use Exception;

class CreateRecurso extends Component
{
    protected $recursosRepository;
    public CreateRecursoForm $form;

    public function __construct()
    {
        $this->recursosRepository = new RecursoCreateRepo();
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
            $this->recursosRepository->crear($this->form->all());
            $this->reset('form.nombre');
            session()->flash('message', 'Recurso creado correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear el recurso. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.recurso.create-recurso');
    }
}
