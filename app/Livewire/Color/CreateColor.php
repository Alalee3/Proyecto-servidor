<?php

namespace App\Livewire\Color;

use App\Livewire\Forms\Color\CreateColorForm;
use Livewire\Component;
use App\Repositories\Color\ColorCreateRepo;
use Exception;

class CreateColor extends Component
{
    public CreateColorForm $form;
    public $coloresExistentes;
    protected $colorRepository;

    public function __construct()
    {
        $this->colorRepository = new ColorCreateRepo();
    }

    public function mount()
    {
        $this->refreshColores();
    }

    public function refreshColores()
    {
        $this->coloresExistentes = \App\Models\Color::where('estatus', '1')
            ->orderBy('nombre_color')
            ->get();
    }

    public function guardar()
    {
        try {
            $this->form->validate();
            $this->colorRepository->crear($this->form->all());
            $this->reset('form.nombre_color', 'form.codigo_color');
            $this->refreshColores();
            $this->showAlert('success', 'Color creado correctamente.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al crear el color. Inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.color.create-color');
    }
}
