<?php

namespace App\Livewire\CalendarioAcademico;

use Livewire\Component;
use Livewire\Attributes\Locked;
use App\Livewire\Forms\CalendarioAcademico\UpdateCalendarioAcademicoForm;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoEditRepo;
use Exception;

class UpdateCalendarioAcademico extends Component
{
    public UpdateCalendarioAcademicoForm $form;

    #[Locked]
    public $calendarioId;
    public $lapsos = [];

    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoEditRepo();
    }

    public function mount($id)
    {
        try {
            $this->calendarioId = $id;
            $this->lapsos = $this->calendarioRepository->obtenerLapsosActivos();

            $calendario = $this->calendarioRepository->mostrar($this->calendarioId);

            if (!$calendario) {
                return redirect()->route('calendario-academico/listar')->with('error', 'Calendario no encontrado.');
            }

            $this->form->fill((array) $calendario);

        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el calendario: ' . $e->getMessage());
            return redirect()->route('calendario-academico/listar');
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
            $this->calendarioRepository->editar($this->calendarioId, $this->form->all());

            return redirect()->route('calendario-academico/listar')
                ->with('message', 'Calendario actualizado correctamente.');

        } catch (Exception $e) {
            return redirect()->route('calendario-academico/listar')
                ->with('error', 'Error al actualizar: ' . $e->getMessage());
        }
    }

    public function cancelar()
    {
        return redirect()->route('calendario-academico/listar');
    }

    public function render()
    {
        return view('livewire.pages.calendario-academico.update-calendario-academico');
    }
}
