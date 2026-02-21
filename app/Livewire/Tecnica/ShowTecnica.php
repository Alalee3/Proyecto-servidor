<?php

namespace App\Livewire\Tecnica;

use Livewire\Component;
use App\Repositories\Tecnica\TecnicaViewRepo;
use Exception;

class ShowTecnica extends Component
{
    public $tecnica;
    protected $tecnicaRepository;

    public function __construct()
    {
        $this->tecnicaRepository = new TecnicaViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->tecnica = $this->tecnicaRepository->mostrar($id);
            if (!$this->tecnica) {
                return redirect()->route('tecnica/listar')->with('error', 'Técnica no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la técnica: ' . $e->getMessage());
            return redirect()->route('tecnica/listar');
        }
    }

    public function cerrar()
    {
        return redirect()->route('tecnica/listar');
    }

    public function render()
    {
        return view('livewire.pages.tecnica.show-tecnica');
    }
}
