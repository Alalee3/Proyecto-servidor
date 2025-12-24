<?php

namespace App\Livewire\Evaluacion;

use Livewire\Component;
use App\Livewire\Forms\Evaluacion\UpdateEvaluacionForm;
use App\Repositories\Evaluacion\EvaluacionEditRepo;
use Exception;

class UpdateEvaluacion extends Component
{
    public UpdateEvaluacionForm $form;
    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new EvaluacionEditRepo();
    }

    public function mount($id)
    {
        try {
            $evaluacion = $this->evaluacionesRepository->obtenerPorId($id);
            if (!$evaluacion) {
                return redirect()->route('evaluacion/listar')->with('error', 'Evaluación no encontrada.');
            }
            $this->form->setForm($evaluacion);
        } catch (Exception $e) {
            return redirect()->route('evaluacion/listar')->with('error', 'Error al cargar la evaluación.');
        }
    }

    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->evaluacionesRepository->actualizar($this->form->id_evaluacion, $this->form->all());
            session()->flash('message', 'Evaluación actualizada correctamente.');
            return redirect()->route('evaluacion/listar');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar la evaluación.');
        }
    }

    public function cancelar()
    {
        return redirect()->route('evaluacion/listar');
    }

    public function render()
    {
        return view('livewire.pages.evaluacion.update-evaluacion');
    }
}
