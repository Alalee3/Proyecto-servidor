<?php

namespace App\Livewire\CalendarioAcademico;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoIndexRepo;
use Exception;

class ListCalendarioAcademico extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoIndexRepo();
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
        try {
            $result = $this->calendarioRepository->inhabilitar($this->idInhabilitar);

            if ($result) {
                session()->flash('message', 'Calendario inhabilitado exitosamente.');
                $this->dispatch('calendarioUpdated');
            } else {
                session()->flash('error', 'No se pudo inhabilitar el calendario.');
            }
        } catch (Exception $e) {
            session()->flash('error', $e->getMessage());
        }

        $this->idInhabilitar = null;
    }

    public function restaurar()
    {
        try {
            $result = $this->calendarioRepository->restaurar($this->idRestaurar);

            if ($result) {
                session()->flash('message', 'Calendario restaurado exitosamente.');
                $this->dispatch('calendarioUpdated');
            } else {
                session()->flash('error', 'No se pudo restaurar el calendario.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar el calendario: ' . $e->getMessage());
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

        return view('livewire.pages.calendario-academico.list-calendario-academico', compact('calendarios'));
    }
}
