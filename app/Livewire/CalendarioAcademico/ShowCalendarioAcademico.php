<?php

namespace App\Livewire\CalendarioAcademico;

use Livewire\Component;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoEditRepo;
use Livewire\Attributes\Locked;

class ShowCalendarioAcademico extends Component
{
    #[Locked]
    public $calendarioId;

    public $calendario;
    public $lapsos = [];
    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoEditRepo();
    }

    public function mount($id)
    {
        $this->calendarioId = $id;
        $this->lapsos = $this->calendarioRepository->obtenerLapsosActivos();
        $this->calendario = $this->calendarioRepository->mostrar($this->calendarioId);

        if (!$this->calendario) {
            return redirect()->route('calendario-academico/listar')->with('error', 'Calendario no encontrado.');
        }
    }

    public function obtenerNombreLapso($id)
    {
        $lapso = collect($this->lapsos)->firstWhere('id_lapso_academico', $id);
        return $lapso ? $lapso->nombre_lapso_academico : 'Desconocido';
    }

    public function render()
    {
        return view('livewire.pages.calendario-academico.show-calendario-academico');
    }
}
