<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class DetalleEstrategia extends Model
{
    use Auditable;

    protected $table = 'detalle_estrategia';
    protected $primaryKey = 'id_detalle_estrategia';
    public $timestamps = false;
    protected $guarded = [];
}
