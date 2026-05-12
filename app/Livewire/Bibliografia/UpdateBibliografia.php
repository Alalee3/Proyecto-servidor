<?php

namespace App\Livewire\Bibliografia;

use App\Livewire\Forms\Bibliografia\UpdateBibliografiaForm;
use Livewire\Component;
use App\Repositories\Bibliografia\BibliografiaEditRepo;
use Exception;

class UpdateBibliografia extends Component
{
    public UpdateBibliografiaForm $form;
    public $bibliografiasExistentes;
    protected $bibliografiasRepository;

    public function __construct()
    {
        $this->bibliografiasRepository = new BibliografiaEditRepo();
    }

    public function mount($id)
    {
        try {
            $bibliografia = $this->bibliografiasRepository->obtenerPorId($id);
            if (!$bibliografia) {
                return redirect()->route('bibliografia/listar')->with('error', 'Bibliografía no encontrada.');
            }
            $this->form->setForm($bibliografia);
            $this->refreshBibliografias();
        } catch (Exception $e) {
            return redirect()->route('bibliografia/listar')->with('error', 'Error al cargar la bibliografía.');
        }
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

    public function actualizar()
    {
        try {
            $this->form->validate();
            $this->bibliografiasRepository->actualizar($this->form->id_bibliografia, $this->form->all());
            $this->showAlert('success', 'Bibliografía actualizada correctamente.', '/bibliografia/list');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al actualizar la bibliografía.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function cancelar()
    {
        return redirect()->route('bibliografia/listar');
    }

    public function render()
    {
        return view('livewire.pages.bibliografia.update-bibliografia');
    }
}
