<?php

namespace App\Livewire\Calendario;

use Livewire\Component;
use App\Livewire\Forms\Calendario\CreateCalendarioForm;
use App\Repositories\Calendario\CalendarioCreateRepo;
use Exception;
use Illuminate\Support\Facades\Gate;

class CreateCalendario extends Component
{
    public CreateCalendarioForm $form;
    protected $calendarioRepository;

    public function boot()
    {
        $this->calendarioRepository = new CalendarioCreateRepo();
    }

    public function save()
    {
        $this->validate();

        if (!Gate::allows('crear-calendario')) {
            abort(403);
        }

        try {
            $id = $this->calendarioRepository->crear($this->form->all());

            if ($id) {
                session()->flash('message', 'Semana de calendario creada exitosamente.');
                return redirect()->route('calendario.list');
            } else {
                session()->flash('error', 'No se pudo crear la semana.');
            }
        } catch (Exception $e) {
            session()->flash('error', $e->getMessage());
        }
    }

    public function render()
    {
        return view('livewire.pages.calendario.create-calendario');
    }
}
