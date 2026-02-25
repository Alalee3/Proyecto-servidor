<?php

namespace App\Livewire\CalendarioAcademico;

use App\Repositories\CalendarioAcademico\CalendarioAcademicoIndexRepo;
use Livewire\Component;
use Livewire\WithPagination;
use Exception;

class ListCalendarioAcademico extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;

    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoIndexRepo();
    }

    public function render()
    {
        $calendarios = $this->calendarioRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.calendario-academico.list-calendario-academico', compact('calendarios'));
    }
}
