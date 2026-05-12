<?php

namespace App\Livewire\Tema;

use App\Livewire\Forms\Tema\CreateTemaForm;
use App\Repositories\Tema\TemaCreateRepo;
use Livewire\Component;

class CreateTema extends Component
{
    public CreateTemaForm $form;
    public $unidadesCurriculares = [];
    public $cortes = [];
    public $temasExistentes = [];
    public $objetivosExistentes = [];

    protected $temaRepo;

    public function boot()
    {
        $this->temaRepo = new TemaCreateRepo();
    }

    public function mount()
    {
        $this->unidadesCurriculares = $this->temaRepo->select_unidades_curriculares();
        $this->cortes = [
            (object) ['id' => '1', 'nombre' => 'Corte 1'],
            (object) ['id' => '2', 'nombre' => 'Corte 2'],
            (object) ['id' => '3', 'nombre' => 'Corte 3'],
            (object) ['id' => '4', 'nombre' => 'Corte 4'],
        ];
        $this->refreshExistentes();
    }

    public function refreshExistentes()
    {
        $this->temasExistentes = \App\Models\Tema::where('estatus', '1')
            ->orderBy('titulo_tema')
            ->get();
        
        $this->objetivosExistentes = \App\Models\Objetivo::where('estatus', '1')
            ->orderBy('titulo_objetivo')
            ->get();
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function save()
    {
        try {
            $this->form->validate();
            $this->temaRepo->crear($this->form->values());
            $this->form->reset();
            $this->form->objetivos = [['titulo_objetivo' => '']]; // Reiniciar con uno vacío
            $this->refreshExistentes();
            $this->showAlert('success', 'Tema creado correctamente.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            $errors = $e->validator->errors()->all();
            $msg = "Hay errores en el formulario:\n\n• " . implode("\n• ", $errors);
            $this->showAlert('error', $msg);
            throw $e;
        } catch (\Exception $e) {
            $this->showAlert('error', 'Error: ' . $e->getMessage());
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function addObjetivo()
    {
        $this->form->objetivos[] = ['titulo_objetivo' => ''];
    }

    public function removeObjetivo($index)
    {
        if (count($this->form->objetivos) > 1) {
            unset($this->form->objetivos[$index]);
            $this->form->objetivos = array_values($this->form->objetivos);
        }
    }

    public function render()
    {
        return view('livewire.pages.tema.create-tema');
    }
}
