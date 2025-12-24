<?php

namespace App\Livewire\Evaluacion;

use Livewire\Component;
use App\Repositories\Evaluacion\EvaluacionViewRepo;
use Exception;

class ShowEvaluacion extends Component
{
    public $evaluacion;
    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new EvaluacionViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->evaluacion = $this->evaluacionesRepository->mostrar($id);
            if (!$this->evaluacion) {
                return redirect()->route('evaluacion/listar')->with('error', 'Evaluación no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la evaluación: ' . $e->getMessage());
            return redirect()->route('evaluacion/listar');
        }
    }

    public function cerrar()
    {
        return redirect()->route('evaluacion/listar');
    }

    public function render()
    {
        return view('livewire.pages.evaluacion.show-evaluacion');
    }
}
