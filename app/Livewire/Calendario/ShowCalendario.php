<?php

namespace App\Livewire\Calendario;

use Livewire\Component;
use App\Repositories\Calendario\CalendarioViewRepo;
use Illuminate\Support\Facades\Gate;

class ShowCalendario extends Component
{
    public $calendario;

    protected $calendarioRepository;

    public function boot()
    {
        $this->calendarioRepository = new CalendarioViewRepo();
    }

    public function mount($id)
    {
        if (!Gate::allows('ver-calendario')) {
            abort(403);
        }

        $this->calendario = $this->calendarioRepository->mostrar($id);

        if (!$this->calendario) {
            abort(404);
        }
    }

    public function render()
    {
        return view('livewire.pages.calendario.show-calendario');
    }
}
