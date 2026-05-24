<?php

namespace App\Livewire\Firma;

use Livewire\Component;
use App\Repositories\Firma\FirmaViewRepo;
use Exception;

class ShowFirma extends Component
{
    public $firma;
    protected $firmaRepository;

    public function __construct()
    {
        $this->firmaRepository = new FirmaViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->firma = $this->firmaRepository->mostrar($id);
            if (!$this->firma) {
                return redirect()->route('firma/listar')->with('error', 'Firma no encontrada.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar la firma: ' . $e->getMessage());
            return redirect()->route('firma/listar');
        }
    }

    public function cerrar()
    {
        return redirect()->route('firma/listar');
    }

    public function render()
    {
        return view('livewire.pages.firma.show-firma');
    }
}
