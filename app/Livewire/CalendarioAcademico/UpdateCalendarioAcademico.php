<?php

namespace App\Livewire\CalendarioAcademico;

use App\Livewire\Forms\CalendarioAcademico\UpdateCalendarioAcademicoForm;
use App\Repositories\CalendarioAcademico\CalendarioAcademicoEditRepo;
use Illuminate\Support\Facades\DB;
use Livewire\Component;
use Livewire\Attributes\Locked;
use Exception;

class UpdateCalendarioAcademico extends Component
{
    public UpdateCalendarioAcademicoForm $form;

    #[Locked]
    public $calendarioId;

    protected $calendarioRepository;

    public function __construct()
    {
        $this->calendarioRepository = new CalendarioAcademicoEditRepo();
    }

    public function mount($id)
    {
        try {
            $this->calendarioId = $id;
            $calendario = $this->calendarioRepository->mostrar($id);

            if (!$calendario) {
                return redirect()->route('calendario-academico/listar')->with('error', 'Registro no encontrado.');
            }

            $this->form->setCalendario($calendario);
        } catch (Exception $e) {
            return redirect()->route('calendario-academico/listar')->with('error', 'Error: ' . $e->getMessage());
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
            session()->flash('error', 'Error al actualizar: ' . $e->getMessage());
        }
    }

    public function cancelar()
    {
        return redirect()->route('calendario-academico/listar');
    }

    public function render()
    {
        $lapsos = DB::table('lapso_academico')
            ->where('estatus', '1')
            ->select('id_lapso_academico', 'nombre_lapso_academico')
            ->get();

        return view('livewire.pages.calendario-academico.update-calendario-academico', compact('lapsos'));
    }
}
