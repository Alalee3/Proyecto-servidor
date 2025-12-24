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

    public function __construct()
    {
        $this->recursosRepository = new RecursoEditRepo();
    }

    public function mount($id)
    {
        try {
            $recurso = $this->recursosRepository->obtenerPorId($id);
            if (!$recurso) {
                return redirect()->route('recurso/listar')->with('error', 'Recurso no encontrado.');
            }
            $this->form->setForm($recurso);
        } catch (Exception $e) {
            return redirect()->route('recurso/listar')->with('error', 'Error al cargar el recurso.');
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
            $this->recursosRepository->actualizar($this->form->id_recurso, $this->form->all());
            session()->flash('message', 'Recurso actualizado correctamente.');
            return redirect()->route('recurso/listar');
        } catch (Exception $e) {
            session()->flash('error', 'Error al actualizar el recurso.');
        }
    }

    public function cancelar()
    {
        return redirect()->route('recurso/listar');
    }

    public function render()
    {
        return view('livewire.pages.recurso.update-recurso');
    }
}
