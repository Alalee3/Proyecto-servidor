<?php

namespace App\Livewire\Forms\Contenido;

use Livewire\Form;
use Livewire\Attributes\Validate;

class UpdateContenidoForm extends Form
{
    public $id;
    public $id_tema;
    public $titulo_contenido;
    public $id_objetivo = [];

    protected function rules()
    {
        return [
            'id_tema' => 'required|exists:tema_unidad,id_tema_unidad',
            'id_objetivo' => 'required|array|min:1',
            'id_objetivo.*' => 'exists:objetivo,id_objetivo',
            'titulo_contenido' => 'required|string|max:255',
        ];
    }

    public function setContenido($contenido)
    {
        $this->id = $contenido->id;
        $this->id_tema = $contenido->id_tema;
        $this->titulo_contenido = $contenido->titulo_contenido;
        // Si el contenido trae objetivos como array de IDs, los seteamos
        $this->id_objetivo = !empty($contenido->id_objetivo) ? (array) $contenido->id_objetivo : [''];
    }

    public function values()
    {
        return [
            'id_objetivo' => $this->id_objetivo,
            'titulo_contenido' => $this->titulo_contenido,
        ];
    }
}
