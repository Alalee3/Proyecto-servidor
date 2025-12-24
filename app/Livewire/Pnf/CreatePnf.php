<?php

namespace App\Livewire\Pnf;

use App\Livewire\Forms\pnf\CreatePnfForm;
use Livewire\Component;
use App\Repositories\pnf\PnfCreateRepo;
use Exception;

class CreatePnf extends Component
{
    protected $pnfsRepository;
    public CreatePnfForm $form;

    public function __construct()
    {
        $this->pnfsRepository = new PnfCreateRepo();
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

            $this->pnfsRepository->crear($this->form->all());

            // Resetea el campo, mostrar un mensaje, redirigir
            $this->reset('form.nombre');
            session()->flash('message', 'PNF creado correctamente.');
        } catch (Exception $e) {
            session()->flash('message', 'Error Intentelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.pnf.create-pnf');
    }
}
