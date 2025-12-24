<?php

namespace App\Livewire\IndicadorLogro;

use App\Livewire\Forms\IndicadorLogro\UpdateIndicadorLogroForm;
use App\Repositories\IndicadorLogro\IndicadorLogroEditRepo;
use Livewire\Component;

use Livewire\Attributes\Locked;

class UpdateIndicadorLogro extends Component
{
    public UpdateIndicadorLogroForm $form;

    #[Locked]
    public $id_indicador;

    protected $indicadorRepo;

    public function __construct()
    {
        $this->indicadorRepo = new IndicadorLogroEditRepo();
    }

    public function mount($id)
    {
        try {
            $this->id_indicador = $id;
            $indicador = $this->indicadorRepo->obtener_por_id($this->id_indicador);

            if (!$indicador) {
                return $this->redirect(route('indicador-logro/listar'), navigate: true);
            }

            $this->form->set_indicador($indicador);
        } catch (\Exception $e) {
            return $this->redirect(route('indicador-logro/listar'), navigate: true);
        }
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->indicadorRepo->actualizar($this->id_indicador, $this->form->values());

            session()->flash('message', 'Indicador de logro actualizado correctamente.');
            return $this->redirect(route('indicador-logro/listar'), navigate: true);
        } catch (\Exception $e) {
            session()->flash('error', 'Error al intentar actualizar el indicador.');
        }
    }

    public function cancelar()
    {
        return $this->redirect(route('indicador-logro/listar'), navigate: true);
    }

    public function render()
    {
        return view('livewire.pages.indicador-logro.update-indicador-logro');
    }
}
