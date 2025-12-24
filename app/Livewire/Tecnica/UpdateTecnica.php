<?php

namespace App\Livewire\Tecnica;

use Livewire\Component;
use App\Livewire\Forms\Tecnica\UpdateTecnicaForm;
use App\Repositories\Tecnica\TecnicaEditRepo;
use Exception;

class UpdateTecnica extends Component
{
    public UpdateTecnicaForm $form;
    protected $tecnicasRepository;

    public function __construct()
    {
        $this->tecnicasRepository = new TecnicaEditRepo();
    }

    public function mount($id)
    {
        try {
            $tecnica = $this->tecnicasRepository->obtenerPorId($id);
            if (!$tecnica) {
                return redirect()->route('tecnica/listar')->with('error', 'Técnica no encontrada.');
            }
            $this->form->setForm($tecnica);
        } catch (Exception $e) {
            return redirect()->route('tecnica/listar')->with('error', 'Error al cargar la técnica.');
        }
    }

    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->tecnicasRepository->actualizar($this->form->id_tecnica, $this->form->all());
            session()->flash('message', 'Técnica actualizada correctamente.');
            return redirect()->route('tecnica/listar');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar la técnica.');
        }
    }

    public function cancelar()
    {
        return redirect()->route('tecnica/listar');
    }

    public function render()
    {
        return view('livewire.pages.tecnica.update-tecnica');
    }
}
