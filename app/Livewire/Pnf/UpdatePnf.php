<?php

namespace App\Livewire\Pnf;

use Livewire\Component;
use Livewire\Attributes\Locked;
use App\Livewire\Forms\Pnf\UpdatePnfForm;
use App\Repositories\Pnf\PnfEditRepo;
use Exception;

class UpdatePnf extends Component
{
    public UpdatePnfForm $form;

    #[Locked]
    public $pnfId;

    protected $pnfsRepository;

    // Inicializamos el repositorio en el constructor para evitar null
    public function __construct()
    {
        $this->pnfsRepository = new PnfEditRepo();
    }

    public function mount($id)
    {
        try {
            $this->pnfId = $id;

            $pnf = $this->pnfsRepository->mostrar($this->pnfId);

            // Convertimos a array y llenamos el formulario
            $this->form->fill((array) $pnf);

        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el PNF: ' . $e->getMessage());
            return redirect()->route('pnf.index');
        }
    }

    // Validación en tiempo real
    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }

    // Actualizar PNF
    public function actualizar()
    {
        $this->form->validate();

        try {
            $this->pnfsRepository->editar($this->pnfId, $this->form->all());

            return redirect()->route('pnf/listar')
                   ->with('message', 'PNF actualizado correctamente.');

        } catch (Exception $e) {
            return redirect()->route('pnf/listar')
                   ->with('error', 'Error al actualizar: ' . $e->getMessage());
        }
    }

    // Cancelar edición
    public function cancelar()
    {
        return redirect()->route('pnf/listar'); 
    }

    public function render()
    {
        return view('livewire.pages.pnf.update-pnf');
    }
}
