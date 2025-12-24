<?php

namespace App\Livewire\Tema;

use App\Livewire\Forms\Tema\CreateTemaForm;
use App\Repositories\Tema\TemaCreateRepo;
use Livewire\Component;

class CreateTema extends Component
{
    public CreateTemaForm $form;
    public $contenidos = [];

    protected $temaRepo;

    public function boot()
    {
        $this->temaRepo = new TemaCreateRepo();
    }

    public function mount()
    {
        $this->contenidos = $this->temaRepo->select_contenidos();
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function save()
    {
        $this->form->validate();
        try {
            $this->temaRepo->crear($this->form->values());
            $this->form->reset();
            session()->flash('message', 'Tema creado correctamente.');
        } catch (\Exception $e) {
            session()->flash('error', 'Error inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.tema.create-tema');
    }
}
