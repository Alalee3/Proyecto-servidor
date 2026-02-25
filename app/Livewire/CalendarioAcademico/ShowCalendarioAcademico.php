<?php

namespace App\Livewire\CalendarioAcademico;

use App\Repositories\CalendarioAcademico\CalendarioAcademicoViewRepo;
use Livewire\Component;
use Livewire\Attributes\Locked;

class ShowCalendarioAcademico extends Component
{
    #[Locked]
    public $calendarioId;

    public $calendario;
    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoViewRepo();
    }

    public function mount($id)
    {
        $this->calendarioId = $id;
        $this->calendario = $this->calendarioRepository->mostrar($id);

        if (!$this->calendario) {
            return redirect()->route('calendario-academico/listar')->with('error', 'Registro no encontrado.');
        }
    }

    public function render()
    {
        $eventos = $this->calendarioRepository->obtenerEventos($this->calendarioId);
        return view('livewire.pages.calendario-academico.show-calendario-academico', compact('eventos'));
    }
}
