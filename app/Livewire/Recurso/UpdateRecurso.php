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
        try {
            $this->form->validate();
            $this->recursosRepository->actualizar($this->recursoId, $this->form->all());
            $this->showAlert('success', 'Recurso actualizado correctamente.', '/recurso/list');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al actualizar el recurso. Inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
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
