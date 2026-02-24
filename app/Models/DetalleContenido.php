<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class DetalleContenido extends Model
{
    use Auditable;

    protected $table = 'detalle_contenido';
    protected $primaryKey = 'id_detalle_contenido';
    public $timestamps = false;
    protected $guarded = [];
}
