<?php

namespace App\Livewire\Contenido;

use App\Livewire\Forms\Contenido\CreateContenidoForm;
use App\Repositories\Contenido\ContenidoCreateRepo;
use Livewire\Component;

class CreateContenido extends Component
{
    public CreateContenidoForm $form;
    public $temas = [];
    public $objetivos = [];

    protected $contenidoRepo;

    public function boot()
    {
        $this->contenidoRepo = new ContenidoCreateRepo();
    }

    public function mount()
    {
        $this->temas = $this->contenidoRepo->select_temas();
    }

    public function updated($propertyName)
    {
        // Detectar si cambió el tema para cargar los objetivos
        if ($propertyName === 'form.id_tema') {
            $this->objetivos = $this->contenidoRepo->select_objetivos_por_tema($this->form->id_tema);
            $this->form->id_objetivo = ['']; // Reiniciar con un solo campo select vacío
        }

        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function addObjetivo()
    {
        $this->form->id_objetivo[] = '';
    }

    public function removeObjetivo($index)
    {
        if (count($this->form->id_objetivo) > 1) {
            unset($this->form->id_objetivo[$index]);
            $this->form->id_objetivo = array_values($this->form->id_objetivo);
        } else {
            $this->form->id_objetivo = ['']; // No dejar el array vacío
        }
    }

    public function save()
    {
        $this->form->validate();
        try {
            $this->contenidoRepo->crear($this->form->values());
            $this->form->reset(); // Resets public properties in the form object
            $this->objetivos = []; // Limpiar la lista de objetivos
            session()->flash('message', 'Contenido creado correctamente.');
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("Error al crear contenido: " . $e->getMessage());
            session()->flash('error', 'Error inténtelo de nuevo: ' . $e->getMessage());
        }
    }

    public function render()
    {
        return view('livewire.pages.contenido.create-contenido');
    }
}
