<?php

namespace App\Livewire\Contenido;

use App\Repositories\Contenido\ContenidoViewRepo;
use Livewire\Component;

class ShowContenido extends Component
{
    public $contenido;

    protected $contenidoRepo;

    public function boot()
    {
        $this->contenidoRepo = new ContenidoViewRepo();
    }

    public function mount($id)
    {
        $this->contenido = $this->contenidoRepo->mostrar($id);
        if (!$this->contenido) {
            return redirect()->route('contenido/listar');
        }
    }

    public function render()
    {
        return view('livewire.pages.contenido.show-contenido');
    }
}
