<?php

namespace App\Livewire\CalendarioAcademico;

use App\Livewire\Forms\CalendarioAcademico\CreateCalendarioAcademicoForm;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoCreateRepo;
use Illuminate\Support\Facades\DB;
use Livewire\Component;
use Exception;

class CreateCalendarioAcademico extends Component
{
    public CreateCalendarioAcademicoForm $form;
    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoCreateRepo();
    }

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    public function guardar()
    {
        $this->form->validate();

        try {
            $this->calendarioRepository->crear($this->form->all());

            $this->form->reset();
            session()->flash('message', 'Semana de calendario creada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear: ' . $e->getMessage());
        }
    }

    public function render()
    {
        $lapsos = DB::table('lapso_academico')
            ->where('estatus', '1')
            ->select('id_lapso_academico', 'nombre_lapso_academico')
            ->get();

        return view('livewire.pages.calendario-academico.create-calendario-academico', compact('lapsos'));
    }
}
