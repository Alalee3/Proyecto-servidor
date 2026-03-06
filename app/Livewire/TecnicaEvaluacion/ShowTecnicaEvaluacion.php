<?php

namespace App\Livewire\TecnicaEvaluacion;

use Livewire\Component;
use App\Repositories\TecnicaEvaluacion\TecnicaEvaluacionViewRepo;
use Exception;

class ShowTecnicaEvaluacion extends Component
{
    public $evaluacion;
    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new TecnicaEvaluacionViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->evaluacion = $this->evaluacionesRepository->mostrar($id);
            if (!$this->evaluacion) {
                return redirect()->route('tecnica-evaluacion/listar')->with('error', 'Evaluación no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la evaluación: ' . $e->getMessage());
            return redirect()->route('tecnica-evaluacion/listar');
        }
    }

    public function cerrar()
    {
        return redirect()->route('tecnica-evaluacion/listar');
    }

    public function render()
    {
        return view('livewire.pages.tecnica-evaluacion.show-tecnica-evaluacion');
    }
}
