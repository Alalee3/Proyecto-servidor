<?php

namespace App\Livewire\CalendarioAcademico;

use App\Livewire\Forms\CalendarioAcademico\CreateCalendarioAcademicoForm;
use Livewire\Component;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoCreateRepo;
use Exception;

class CreateCalendarioAcademico extends Component
{
    public CreateCalendarioAcademicoForm $form;
    protected $calendarioRepository;
    public $lapsos = [];

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoCreateRepo();
    }

    public function mount()
    {
        $this->lapsos = $this->calendarioRepository->obtenerLapsosActivos();
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

            $this->reset('form.id_lapso_academico', 'form.semana', 'form.dia_inicio', 'form.dia_fin', 'form.carga_corte');
            session()->flash('message', 'Calendario creado correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al crear calendario: ' . $e->getMessage());
        }
    }

    public function render()
    {
        return view('livewire.pages.calendario-academico.create-calendario-academico');
    }
}
