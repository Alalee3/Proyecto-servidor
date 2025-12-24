<?php

namespace App\Livewire\Tema;

use App\Livewire\Forms\Tema\UpdateTemaForm;
use App\Repositories\Tema\TemaCreateRepo;
use App\Repositories\Tema\TemaEditRepo;
use Livewire\Component;

class UpdateTema extends Component
{
    public UpdateTemaForm $form;
    public $contenidos = [];

    protected $temaRepo;
    protected $temaEditRepo;

    public function boot()
    {
        $this->temaRepo = new TemaCreateRepo();
        $this->temaEditRepo = new TemaEditRepo();
    }

    public function mount($id)
    {
        $tema = $this->temaEditRepo->mostrar($id);
        if (!$tema) {
            return redirect()->route('tema/listar');
        }

        $this->form->setTema($tema);
        $this->contenidos = $this->temaRepo->select_contenidos();
    }

    public function save()
    {
        $this->form->validate();
        try {
            $this->temaEditRepo->editar($this->form->id, $this->form->values());
            session()->flash('message', 'Tema actualizado con éxito.');
            return redirect()->route('tema/listar');
        } catch (\Exception $e) {
            session()->flash('error', 'Error inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.tema.update-tema');
    }
}
