<?php

namespace App\Livewire\Bitacora;

use Livewire\Component;
use App\Repositories\Bitacora\BitacoraViewRepo;
use Exception;

class ShowBitacora extends Component
{
    public $bitacora;
    protected $bitacoraRepository;

    public function __construct()
    {
        $this->bitacoraRepository = new BitacoraViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->bitacora = $this->bitacoraRepository->mostrar($id);
            if (!$this->bitacora) {
                return redirect()->route('bitacora/listar')->with('error', 'Registro de bitácora no encontrado.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el registro de la bitácora: ' . $e->getMessage());
            return redirect()->route('bitacora/listar');
        }
    }

    public function render()
    {
        return view('livewire.pages.bitacora.show-bitacora');
    }

    public function cerrar()
    {
        return redirect()->route('bitacora/listar');
    }
}
