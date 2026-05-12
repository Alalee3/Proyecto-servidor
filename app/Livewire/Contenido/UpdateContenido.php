<?php

namespace App\Livewire\Contenido;

use App\Livewire\Forms\Contenido\UpdateContenidoForm;
use App\Repositories\Contenido\ContenidoCreateRepo;
use App\Repositories\Contenido\ContenidoEditRepo;
use Livewire\Component;

class UpdateContenido extends Component
{
    public UpdateContenidoForm $form;
    public $temas = [];
    public $objetivos = [];
    public $contenidosExistentes = [];

    protected $contenidoRepo;
    protected $contenidoEditRepo;

    public function boot()
    {
        $this->contenidoRepo = new ContenidoCreateRepo();
        $this->contenidoEditRepo = new ContenidoEditRepo();
    }

    public function mount($id)
    {
        $contenido = $this->contenidoEditRepo->mostrar($id);
        if (!$contenido) {
            return redirect()->route('contenido/listar');
        }

        $this->form->setContenido($contenido);
        $this->temas = $this->contenidoRepo->select_temas();
        
        // Cargar objetivos del tema actual
        if ($this->form->id_tema) {
            $this->objetivos = $this->contenidoRepo->select_objetivos_por_tema($this->form->id_tema);
        }

        $this->refreshContenidos();
    }

    public function refreshContenidos()
    {
        $this->contenidosExistentes = \App\Models\Contenido::where('estatus', '1')
            ->orderBy('titulo_contenido')
            ->get();
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
            $this->contenidoEditRepo->editar($this->form->id, $this->form->values());
            session()->flash('message', 'Contenido actualizado con éxito.');
            return redirect()->route('contenido/listar');
        } catch (\Exception $e) {
            session()->flash('error', 'Error al actualizar el contenido.');
        }
    }

    public function render()
    {
        return view('livewire.pages.contenido.update-contenido');
    }
}
