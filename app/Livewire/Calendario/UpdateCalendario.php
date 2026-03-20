<?php

namespace App\Livewire\Calendario;

use Livewire\Component;
use App\Livewire\Forms\Calendario\UpdateCalendarioForm;
use App\Repositories\Calendario\CalendarioEditRepo;
use Exception;
use Illuminate\Support\Facades\Gate;

class UpdateCalendario extends Component
{
    public UpdateCalendarioForm $form;
    protected $calendarioRepository;

    public function boot()
    {
        $this->calendarioRepository = new CalendarioEditRepo();
    }

    public function mount($id)
    {
        if (!Gate::allows('editar-calendario')) {
            abort(403);
        }

        $calendario = $this->calendarioRepository->obtener($id);

        if (!$calendario) {
            abort(404);
        }

        $this->form->setCalendario($calendario);
    }

    public function update()
    {
        $this->validate();

        try {
            $result = $this->calendarioRepository->actualizar($this->form->id_calendario_academico, $this->form->all());

            if ($result) {
                session()->flash('message', 'Semana de calendario actualizada exitosamente.');
                return redirect()->route('calendario.list');
            } else {
                session()->flash('error', 'No se pudo actualizar la semana.');
            }
        } catch (Exception $e) {
            session()->flash('error', $e->getMessage());
        }
    }

    public function render()
    {
        return view('livewire.pages.calendario.update-calendario');
    }
}
