<?php

namespace App\Livewire\Bibliografia;

use App\Livewire\Forms\Bibliografia\CreateBibliografiaForm;
use Livewire\Component;
use App\Repositories\Bibliografia\BibliografiaCreateRepo;
use Exception;

class CreateBibliografia extends Component
{
    public CreateBibliografiaForm $form;
    public $bibliografiasExistentes;
    protected $bibliografiasRepository;

    public function __construct()
    {
        $this->bibliografiasRepository = new BibliografiaCreateRepo();
    }

    public function mount()
    {
        $this->refreshBibliografias();
    }

    public function refreshBibliografias()
    {
        $this->bibliografiasExistentes = \App\Models\Bibliografia::where('estatus', '1')
            ->orderBy('nombre_bibliografia')
            ->get();
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->bibliografiasRepository->crear($this->form->all());
            $this->reset('form.nombre');
            $this->refreshBibliografias();
            session()->flash('message', 'Bibliografía creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear la bibliografía. Inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.bibliografia.create-bibliografia');
    }
}
