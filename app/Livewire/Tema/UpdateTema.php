<?php

namespace App\Livewire\Tema;

use App\Livewire\Forms\Tema\UpdateTemaForm;
use App\Repositories\Tema\TemaCreateRepo;
use App\Repositories\Tema\TemaEditRepo;
use Livewire\Component;

class UpdateTema extends Component
{
    public UpdateTemaForm $form;
    public $unidadesCurriculares = [];
    public $cortes = [];
    public $temasExistentes = [];
    public $objetivosExistentes = [];

    protected $temaRepo;
    protected $temaEditRepo;

    public function boot()
    {
        $this->temaRepo = new TemaCreateRepo();
        $this->temaEditRepo = new TemaEditRepo();
    }

    public function mount($id)
    {
        $tema = $this->temaEditRepo->mostrar($id);
        if (!$tema) {
            return redirect()->route('tema/listar');
        }

        $this->form->setTema($tema, $tema->objetivos ?? []);
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

    public function save()
    {
        $this->form->validate();
        try {
            $this->temaEditRepo->editar($this->form->id, $this->form->values());
            session()->flash('message', 'Tema actualizado con éxito.');
            return redirect()->route('tema/listar');
        } catch (\Exception $e) {
            session()->flash('error', 'Error inténtelo de nuevo.');
        }
    }

    public function render()
    {
        return view('livewire.pages.tema.update-tema');
    }
}
