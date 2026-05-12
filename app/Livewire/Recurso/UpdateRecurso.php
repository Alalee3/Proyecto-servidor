<?php

namespace App\Livewire\Recurso;

use App\Livewire\Forms\Recurso\UpdateRecursoForm;
use Livewire\Component;
use App\Repositories\Recurso\RecursoEditRepo;
use Exception;

class UpdateRecurso extends Component
{
    protected $recursosRepository;
    public UpdateRecursoForm $form;
    public $recursoId;
    public $recursosExistentes;

    public function __construct()
    {
        $this->recursosRepository = new RecursoEditRepo();
    }

    public function mount($recursoId)
    {
        $this->recursoId = $recursoId;
        $this->form->setRecurso($recursoId);
        $this->refreshRecursos();
    }

    public function refreshRecursos()
    {
        $this->recursosExistentes = \App\Models\Recurso::where('estatus', '1')
            ->orderBy('nombre_recurso')
            ->get();
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
            $this->recursosRepository->actualizar($this->recursoId, $this->form->all());
            session()->flash('message', 'Recurso actualizado correctamente.');
            return redirect()->to('/recurso/list');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar el recurso. Inténtelo de nuevo.');
        }
    }

    public function cancelar()
    {
        return redirect()->to('/recurso/list');
    }

    public function render()
    {
        return view('livewire.pages.recurso.update-recurso');
    }
}
