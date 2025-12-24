<?php

namespace App\Livewire\Recurso;

use Livewire\Component;
use App\Repositories\Recurso\RecursoViewRepo;
use Exception;

class ShowRecurso extends Component
{
    public $recurso;
    protected $recursosRepository;

    public function __construct()
    {
        $this->recursosRepository = new RecursoViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->recurso = $this->recursosRepository->mostrar($id);
            if (!$this->recurso) {
                return redirect()->route('recurso/listar')->with('error', 'Recurso no encontrado.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el recurso: ' . $e->getMessage());
            return redirect()->route('recurso/listar');
        }
    }

    public function render()
    {
        return view('livewire.pages.recurso.show-recurso');
    }

    public function cerrar()
    {
        return redirect()->route('recurso/listar');
    }
}
