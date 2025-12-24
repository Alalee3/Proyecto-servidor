<?php

namespace App\Livewire\Bibliografia;

use App\Livewire\Forms\Bibliografia\UpdateBibliografiaForm;
use Livewire\Component;
use App\Repositories\Bibliografia\BibliografiaEditRepo;
use Exception;

class UpdateBibliografia extends Component
{
    protected $bibliografiasRepository;
    public UpdateBibliografiaForm $form;

    public function __construct()
    {
        $this->bibliografiasRepository = new BibliografiaEditRepo();
    }

    public function mount($id)
    {
        try {
            $bibliografia = $this->bibliografiasRepository->obtenerPorId($id);
            if (!$bibliografia) {
                return redirect()->route('bibliografia/listar')->with('error', 'Bibliografía no encontrada.');
            }
            $this->form->setForm($bibliografia);
        } catch (Exception $e) {
            return redirect()->route('bibliografia/listar')->with('error', 'Error al cargar la bibliografía.');
        }
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->bibliografiasRepository->actualizar($this->form->id_bibliografia, $this->form->all());
            session()->flash('message', 'Bibliografía actualizada correctamente.');
            return redirect()->route('bibliografia/listar');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar la bibliografía.');
        }
    }

    public function cancelar()
    {
        return redirect()->route('bibliografia/listar');
    }

    public function render()
    {
        return view('livewire.pages.bibliografia.update-bibliografia');
    }
}
