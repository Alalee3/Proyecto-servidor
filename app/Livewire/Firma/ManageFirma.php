<?php

namespace App\Livewire\Firma;

use App\Livewire\Forms\Firma\CreateFirmaForm;
use Livewire\Component;
use Livewire\WithFileUploads;
use App\Models\Firma;
use App\Services\FirmaService;
use App\Repositories\Firma\ManageFirmaRepo;
use Exception;

class ManageFirma extends Component
{
    use WithFileUploads;

    public CreateFirmaForm $form;
    public $firmaActual = null;
    protected ManageFirmaRepo $repo;

    public function boot(ManageFirmaRepo $repo)
    {
        $this->repo = $repo;
    }

    public function mount()
    {
        $this->cargarFirmaActual();
    }

    public function cargarFirmaActual()
    {
        $this->firmaActual = $this->repo->obtenerFirmaActual(auth()->user()->usu_codigo);
    }

    public function updatedFormFotoFirma()
    {
        try {
            $this->form->validateOnly('foto_firma');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $this->reset('form.foto_firma');
            $this->showAlert('warning', $e->validator->errors()->first('foto_firma'));
        }
    }

    public function guardar()
    {
        try {
            $this->form->validate();

            $pngData = FirmaService::maikol_callate($this->form->foto_firma);
            $pngData = FirmaService::optimizarParaFirma($pngData);

            $this->repo->guardarFirma(auth()->user()->usu_codigo, $pngData);

            $this->reset('form.foto_firma');
            $this->cargarFirmaActual();
            
            $this->showAlert('success', 'Firma guardada correctamente. El fondo ha sido eliminado y convertido a PNG.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al guardar la firma: ' . $e->getMessage());
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.firma.manage-firma');
    }
}
