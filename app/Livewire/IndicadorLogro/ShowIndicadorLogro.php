<?php

namespace App\Livewire\IndicadorLogro;

use App\Repositories\IndicadorLogro\IndicadorLogroViewRepo;
use Livewire\Component;

class ShowIndicadorLogro extends Component
{
    public $indicador;

    protected $indicadorRepo;

    public function boot()
    {
        $this->indicadorRepo = new IndicadorLogroViewRepo();
    }

    public function mount($id)
    {
        $this->indicador = $this->indicadorRepo->obtener_detalles($id);

        if (!$this->indicador) {
            return $this->redirect(route('indicador-logro/listar'), navigate: true);
        }
    }

    public function render()
    {
        return view('livewire.pages.indicador-logro.show-indicador-logro');
    }
}
