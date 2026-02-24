<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class DetalleEstrategiaRecurso extends Model
{
    use Auditable;

    protected $table = 'detalle_estrategia_recurso';
    protected $primaryKey = 'id_detalle_estrategia_recurso';
    public $timestamps = false;
    protected $guarded = [];
}
