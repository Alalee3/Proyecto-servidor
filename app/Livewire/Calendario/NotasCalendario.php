<?php

namespace App\Livewire\Calendario;

use Livewire\Component;
use App\Repositories\Calendario\NotasCalendarioRepo;
use App\Livewire\Forms\Calendario\NotasCalendarioForm;
use Exception;

class NotasCalendario extends Component
{
    public NotasCalendarioForm $form;
    public $calendario;
    protected $repo;

    public function boot()
    {
        $this->repo = new NotasCalendarioRepo();
    }

    public function mount($id)
    {
        $this->calendario = $this->repo->obtenerCalendario($id);
        
        // Bloquear si el calendario no está activo
        if ($this->calendario->estatus != 1) {
            abort(403, 'Solo se pueden agregar notas a calendarios activos.');
        }

        $this->form->setNotas($this->calendario->nota_calendario_academico);
    }

    public function agregarNota()
    {
        $this->form->agregarNota();
        $this->guardar();
    }

    public function eliminarNota($index)
    {
        $this->form->eliminarNota($index);
        $this->guardar();
    }

    protected function guardar()
    {
        try {
            $this->repo->actualizarNotas($this->calendario, $this->form->notas);
            $this->dispatch('show-alert', [
                'type' => 'success',
                'message' => 'Notas actualizadas correctamente.'
            ]);
        } catch (Exception $e) {
            $this->dispatch('show-alert', [
                'type' => 'error',
                'message' => 'Ocurrió un error al guardar las notas.'
            ]);
        }
    }

    public function cancelar()
    {
        return redirect()->route('calendario.list');
    }

    public function render()
    {
        return view('livewire.pages.calendario.notas-calendario');
    }
}
