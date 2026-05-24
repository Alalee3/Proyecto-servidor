<?php

namespace App\Livewire\Firma;

use App\Livewire\Forms\Firma\CreateFirmaForm;
use Livewire\Component;
use Livewire\WithFileUploads;
use App\Repositories\Firma\FirmaCreateRepo;
use App\Services\FirmaService;
use Exception;

class CreateFirma extends Component
{
    use WithFileUploads;

    public CreateFirmaForm $form;
    protected $firmaRepository;

    public function __construct()
    {
        $this->firmaRepository = new FirmaCreateRepo();
    }

    public function guardar()
    {
        try {
            $this->form->validate();

            $pngData = FirmaService::maikol_callate($this->form->foto_firma);
            $pngData = FirmaService::optimizarParaFirma($pngData);

            $this->firmaRepository->crear(['foto_firma' => $pngData]);

            $this->reset('form.foto_firma');
            $this->showAlert('success', 'Firma creada correctamente. El fondo ha sido eliminado y convertido a PNG.', '/firma/list');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al crear la firma: ' . $e->getMessage());
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        return view('livewire.pages.firma.create-firma');
    }
}
