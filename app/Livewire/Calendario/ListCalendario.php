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

    protected $calendarioRepository;

    public function boot()
    {
        $this->calendarioRepository = new CalendarioIndexRepo();
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
