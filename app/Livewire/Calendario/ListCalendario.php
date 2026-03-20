<?php

namespace App\Livewire\Calendario;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Calendario\CalendarioIndexRepo;
use Exception;
use Illuminate\Support\Facades\Gate;

class ListCalendario extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $calendarioRepository;

    public function boot()
    {
        $this->calendarioRepository = new CalendarioIndexRepo();
    }

    public function confirmarInhabilitar($id)
    {
        $this->idInhabilitar = $id;
    }

    public function confirmarRestaurar($id)
    {
        $this->idRestaurar = $id;
    }

    public function inhabilitar()
    {
        if (!Gate::allows('cambiar-estatus-calendario')) { 
            abort(403);
        }

        try {
            $result = $this->calendarioRepository->inhabilitar($this->idInhabilitar);

            if ($result) {
                session()->flash('message', 'Semana de calendario inhabilitado exitosamente.');
                $this->dispatch('calendarioUpdated');
            } else {
                session()->flash('error', 'No se pudo inhabilitar la semana.');
            }
        } catch (Exception $e) {
            session()->flash('error', $e->getMessage());
        }

        $this->idInhabilitar = null;
    }

    public function restaurar()
    {
        if (!Gate::allows('cambiar-estatus-calendario')) {
            abort(403);
        }

        try {
            $result = $this->calendarioRepository->restaurar($this->idRestaurar);

            if ($result) {
                session()->flash('message', 'Semana de calendario restaurada exitosamente.');
                $this->dispatch('calendarioUpdated');
            } else {
                session()->flash('error', 'No se pudo restaurar la semana.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar la semana: ' . $e->getMessage());
        }

        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $calendarios = $this->calendarioRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.calendario.list-calendario', compact('calendarios'));
    }
}
