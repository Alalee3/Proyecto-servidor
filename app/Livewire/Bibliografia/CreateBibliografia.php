<?php

namespace App\Livewire\Bibliografia;

use App\Livewire\Forms\Bibliografia\CreateBibliografiaForm;
use Livewire\Component;
use App\Repositories\Bibliografia\BibliografiaCreateRepo;
use Exception;

class CreateBibliografia extends Component
{
    public CreateBibliografiaForm $form;
    public $bibliografiasExistentes;
    protected $bibliografiasRepository;

    public function __construct()
    {
        $this->bibliografiasRepository = new BibliografiaCreateRepo();
    }

    public function mount()
    {
        $this->refreshBibliografias();
    }

    public function refreshBibliografias()
    {
        $this->bibliografiasExistentes = \App\Models\Bibliografia::where('estatus', '1')
            ->orderBy('nombre_bibliografia')
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
            $this->bibliografiasRepository->crear($this->form->all());
            $this->reset('form.nombre');
            $this->refreshBibliografias();
            $this->showAlert('success', 'Bibliografía creada correctamente.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al crear la bibliografía. Inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.bibliografia.create-bibliografia');
    }
}
