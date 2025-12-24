<?php

namespace App\Livewire\Forms\Contenido;

use Livewire\Form;
use Livewire\Attributes\Validate;

class UpdateContenidoForm extends Form
{
    public $id;

    #[Validate('required|exists:unidad_curricular,id_unidad_curricular')]
    public $id_unidad_curricular;

    #[Validate('required|string|max:255')]
    public $titulo_contenido;

    #[Validate('nullable|string')]
    public $descripcion_contenido;

    #[Validate('required|in:1,2,3,4')]
    public $corte_contenido;

    public function setContenido($contenido)
    {
        $this->id = $contenido->id;
        $this->id_unidad_curricular = $contenido->id_unidad_curricular;
        $this->titulo_contenido = $contenido->titulo_contenido;
        $this->descripcion_contenido = $contenido->descripcion_contenido;
        $this->corte_contenido = $contenido->corte_contenido;
    }

    public function values()
    {
        return [
            'id_unidad_curricular' => $this->id_unidad_curricular,
            'titulo_contenido' => $this->titulo_contenido,
            'descripcion_contenido' => $this->descripcion_contenido,
            'corte_contenido' => $this->corte_contenido,
        ];
    }
}
