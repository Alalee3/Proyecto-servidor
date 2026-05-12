<?php

namespace App\Livewire\Recurso;

use App\Livewire\Forms\Recurso\CreateRecursoForm;
use Livewire\Component;
use App\Repositories\Recurso\RecursoCreateRepo;
use Exception;

class CreateRecurso extends Component
{
    protected $recursosRepository;
    public CreateRecursoForm $form;
    public $recursosExistentes;

    public function __construct()
    {
        $this->recursosRepository = new RecursoCreateRepo();
    }

    public function mount()
    {
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

    public function guardar()
    {
        try {
            $this->form->validate();
            $this->recursosRepository->crear($this->form->all());
            $this->reset('form.nombre');
            $this->refreshRecursos();
            $this->showAlert('success', 'Recurso creado correctamente.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al crear el recurso. Inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.recurso.create-recurso');
    }
}
