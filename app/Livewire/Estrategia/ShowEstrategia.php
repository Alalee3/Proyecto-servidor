<?php

namespace App\Livewire\Estrategia;

use Livewire\Component;
use App\Repositories\Estrategia\EstrategiaViewRepo;
use Exception;

class ShowEstrategia extends Component
{
    public $estrategia;
    protected $estrategiasRepository;

    public function __construct()
    {
        $this->estrategiasRepository = new EstrategiaViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->estrategia = $this->estrategiasRepository->mostrar($id);
            if (!$this->estrategia) {
                return redirect()->route('estrategia/listar')->with('error', 'Estrategia no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la estrategia: ' . $e->getMessage());
            return redirect()->route('estrategia/listar');
        }
    }

    public function cerrar()
    {
        return redirect()->route('estrategia/listar');
    }

    public function render()
    {
        return view('livewire.pages.estrategia.show-estrategia');
    }
}
