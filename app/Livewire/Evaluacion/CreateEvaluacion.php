<?php

namespace App\Livewire\Evaluacion;

use Livewire\Component;
use App\Livewire\Forms\Evaluacion\CreateEvaluacionForm;
use App\Repositories\Evaluacion\EvaluacionCreateRepo;
use Exception;

class CreateEvaluacion extends Component
{
    public CreateEvaluacionForm $form;
    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new EvaluacionCreateRepo();
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->evaluacionesRepository->crear($this->form->all());
            $this->reset('form.nombre');
            session()->flash('message', 'Evaluación creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear la evaluación. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.evaluacion.create-evaluacion');
    }
}
