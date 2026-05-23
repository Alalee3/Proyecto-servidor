<?php

namespace App\Livewire\Color;

use App\Livewire\Forms\Color\UpdateColorForm;
use Livewire\Component;
use App\Repositories\Color\ColorUpdateRepo;
use Exception;

class UpdateColor extends Component
{
    public UpdateColorForm $form;
    public $coloresExistentes;
    protected $colorRepository;

    public function __construct()
    {
        $this->colorRepository = new ColorUpdateRepo();
    }

    public function mount($id)
    {
        try {
            $color = $this->colorRepository->obtenerPorId($id);
            if (!$color) {
                return redirect()->route('color.list')->with('error', 'Color no encontrado.');
            }
            $this->form->setForm($color);
            $this->refreshColores();
        } catch (Exception $e) {
            return redirect()->route('color.list')->with('error', 'Error al cargar el color.');
        }
    }

    public function refreshColores()
    {
        $this->coloresExistentes = \App\Models\Color::where('estatus', '1')
            ->orderBy('nombre_color')
            ->get();
    }

    public function actualizar()
    {
        try {
            $this->form->validate();
            $this->colorRepository->actualizar($this->form->id_color, $this->form->all());
            $this->showAlert('success', 'Color actualizado correctamente.', '/color/list');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al actualizar el color. Inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function cancelar()
    {
        return redirect()->route('color.list');
    }

    public function render()
    {
        return view('livewire.pages.color.edit-color');
    }
}
