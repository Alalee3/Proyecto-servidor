<?php

namespace App\Livewire\Tema;

use App\Repositories\Tema\TemaViewRepo;
use Livewire\Component;

class ShowTema extends Component
{
    public $tema;

    protected $temaRepo;

    public function boot()
    {
        $this->temaRepo = new TemaViewRepo();
    }

    public function mount($id)
    {
        $this->tema = $this->temaRepo->mostrar($id);
        if (!$this->tema) {
            return redirect()->route('tema/listar');
        }
    }

    public function render()
    {
        return view('livewire.pages.tema.show-tema');
    }
}
