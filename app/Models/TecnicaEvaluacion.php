<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class TecnicaEvaluacion extends Model
{
    use Auditable;

    protected $table = 'tecnica_evaluacion';
    protected $primaryKey = 'id_tecnica_evaluacion';
    public $timestamps = false;
    protected $guarded = [];
}
