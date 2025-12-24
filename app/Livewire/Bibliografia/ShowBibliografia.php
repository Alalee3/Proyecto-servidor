<?php

namespace App\Livewire\Bibliografia;

use Livewire\Component;
use App\Repositories\Bibliografia\BibliografiaViewRepo;
use Exception;

class ShowBibliografia extends Component
{
    public $bibliografia;
    protected $bibliografiasRepository;

    public function __construct()
    {
        $this->bibliografiasRepository = new BibliografiaViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->bibliografia = $this->bibliografiasRepository->mostrar($id);
            if (!$this->bibliografia) {
                return redirect()->route('bibliografia/listar')->with('error', 'Bibliografía no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la bibliografía: ' . $e->getMessage());
            return redirect()->route('bibliografia/listar');
        }
    }

    public function render()
    {
        return view('livewire.pages.bibliografia.show-bibliografia');
    }

    public function cerrar()
    {
        return redirect()->route('bibliografia/listar');
    }
}
