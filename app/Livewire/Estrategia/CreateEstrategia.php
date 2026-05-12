<?php

namespace App\Livewire\Estrategia;

use Livewire\Component;
use App\Livewire\Forms\Estrategia\CreateEstrategiaForm;
use App\Repositories\Estrategia\EstrategiaCreateRepo;
use Exception;

class CreateEstrategia extends Component
{
    public CreateEstrategiaForm $form;
    public $estrategiasExistentes;
    protected $estrategiasRepository;

    public function __construct()
    {
        $this->estrategiasRepository = new EstrategiaCreateRepo();
    }

    public function mount()
    {
        $this->refreshEstrategias();
    }

    public function refreshEstrategias()
    {
        $this->estrategiasExistentes = \App\Models\Estrategia::where('estatus', '1')
            ->orderBy('nombre_tecnica_actividad')
            ->get();
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->estrategiasRepository->crear($this->form->all());
            $this->reset('form.nombre');
            $this->refreshEstrategias();
            session()->flash('message', 'Estrategia pedagógica creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear la estrategia pedagógica. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.estrategia.create-estrategia');
    }
}
