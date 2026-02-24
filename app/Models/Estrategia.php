<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Estrategia extends Model
{
    use Auditable;

    protected $table = 'tecnica_actividad';
    protected $primaryKey = 'id_tecnica_actividad';
    public $timestamps = false;
    protected $guarded = [];
}
