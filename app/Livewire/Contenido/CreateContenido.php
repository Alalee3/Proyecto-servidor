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
    public $contenidosExistentes = [];

    protected $contenidoRepo;

    public function boot()
    {
        $this->contenidoRepo = new ContenidoCreateRepo();
    }

    public function mount()
    {
        $this->temas = $this->contenidoRepo->select_temas();
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
        try {
            $this->form->validate();
            $this->contenidoRepo->crear($this->form->values());
            $this->form->reset(); // Resets public properties in the form object
            $this->objetivos = []; // Limpiar la lista de objetivos
            $this->refreshContenidos();
            $this->showAlert('success', 'Contenido creado correctamente.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("Error al crear contenido: " . $e->getMessage());
            $this->showAlert('error', 'Error inténtelo de nuevo: ' . $e->getMessage());
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.contenido.create-contenido');
    }
}
