<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class DetalleEvaluacion extends Model
{
    use Auditable;

    protected $table = 'detalle_evaluacion';
    protected $primaryKey = 'id_detalle_evaluacion';
    public $timestamps = false;
    protected $guarded = [];
}
