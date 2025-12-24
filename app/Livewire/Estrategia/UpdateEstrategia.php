<?php

namespace App\Livewire\Estrategia;

use Livewire\Component;
use App\Livewire\Forms\Estrategia\UpdateEstrategiaForm;
use App\Repositories\Estrategia\EstrategiaEditRepo;
use Exception;

class UpdateEstrategia extends Component
{
    public UpdateEstrategiaForm $form;
    protected $estrategiasRepository;

    public function __construct()
    {
        $this->estrategiasRepository = new EstrategiaEditRepo();
    }

    public function mount($id)
    {
        try {
            $estrategia = $this->estrategiasRepository->obtenerPorId($id);
            if (!$estrategia) {
                return redirect()->route('estrategia/listar')->with('error', 'Estrategia no encontrada.');
            }
            $this->form->setForm($estrategia);
        } catch (Exception $e) {
            return redirect()->route('estrategia/listar')->with('error', 'Error al cargar la estrategia.');
        }
    }

    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->estrategiasRepository->actualizar($this->form->id_estrategia_pedagogica, $this->form->all());
            session()->flash('message', 'Estrategia actualizada correctamente.');
            return redirect()->route('estrategia/listar');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar la estrategia.');
        }
    }

    public function cancelar()
    {
        return redirect()->route('estrategia/listar');
    }

    public function render()
    {
        return view('livewire.pages.estrategia.update-estrategia');
    }
}
