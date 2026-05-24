<?php

namespace App\Livewire\Firma;

use App\Livewire\Forms\Firma\UpdateFirmaForm;
use Livewire\Component;
use Livewire\WithFileUploads;
use App\Repositories\Firma\FirmaUpdateRepo;
use App\Services\FirmaService;
use Exception;

class UpdateFirma extends Component
{
    use WithFileUploads;

    public UpdateFirmaForm $form;
    protected $firmaRepository;

    public function __construct()
    {
        $this->firmaRepository = new FirmaUpdateRepo();
    }

    public function mount($id)
    {
        try {
            $firma = $this->firmaRepository->obtenerPorId($id);
            if (!$firma) {
                return redirect()->route('firma/listar')->with('error', 'Firma no encontrada.');
            }
            $this->form->setForm($firma);
        } catch (Exception $e) {
            return redirect()->route('firma/listar')->with('error', 'Error al cargar la firma.');
        }
    }

    public function actualizar()
    {
        try {
            $this->form->validate();

            $datos = [];

            // Si hay nueva imagen, procesarla con maikol_callate
            if ($this->form->foto_firma) {
                $pngData = FirmaService::maikol_callate($this->form->foto_firma);
                $pngData = FirmaService::optimizarParaFirma($pngData);
                $datos['foto_firma'] = $pngData;
            }

            $this->firmaRepository->actualizar($this->form->id_firma, $datos);

            $msg = 'Firma actualizada correctamente.';
            if ($this->form->foto_firma) {
                $msg .= ' La nueva imagen ha sido procesada (fondo eliminado, convertida a PNG).';
            }
            $this->showAlert('success', $msg, '/firma/list');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (Exception $e) {
            $this->showAlert('error', 'Error al actualizar la firma: ' . $e->getMessage());
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function cancelar()
    {
        return redirect()->route('firma/listar');
    }

    public function render()
    {
        return view('livewire.pages.firma.update-firma');
    }
}
