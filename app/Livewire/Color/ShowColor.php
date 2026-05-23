<?php

namespace App\Livewire\Color;

use Livewire\Component;
use App\Repositories\Color\ColorViewRepo;
use Exception;

class ShowColor extends Component
{
    public $color;
    protected $colorRepository;

    public function __construct()
    {
        $this->colorRepository = new ColorViewRepo();
    }

    public function mount(int $id)
    {
        try {
            $this->color = $this->colorRepository->mostrar($id);
            if (!$this->color) {
                return redirect()->route('color.list')->with('error', 'Color no encontrado.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el color: ' . $e->getMessage());
            return redirect()->route('color.list');
        }
    }

    public function cerrar()
    {
        return redirect()->route('color.list');
    }

    public function render()
    {
        return view('livewire.pages.color.show-color');
    }
}
