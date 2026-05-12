<?php

namespace App\Livewire\TecnicaEvaluacion;

use Livewire\Component;
use App\Livewire\Forms\TecnicaEvaluacion\CreateTecnicaEvaluacionForm;
use App\Repositories\TecnicaEvaluacion\TecnicaEvaluacionCreateRepo;
use Exception;

class CreateTecnicaEvaluacion extends Component
{
    public CreateTecnicaEvaluacionForm $form;
    public $tecnicasExistentes;
    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new TecnicaEvaluacionCreateRepo();
    }

    public function mount()
    {
        $this->refreshTecnicas();
    }

    public function refreshTecnicas()
    {
        $this->tecnicasExistentes = \App\Models\TecnicaEvaluacion::where('estatus', '1')
            ->orderBy('nombre_tecnica_evaluacion')
            ->get();
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->evaluacionesRepository->crear($this->form->all());
            $this->reset('form.nombre');
            $this->refreshTecnicas();
            session()->flash('message', 'Técnica de evaluación creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear la técnica de evaluación. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.tecnica-evaluacion.create-tecnica-evaluacion');
    }
}
