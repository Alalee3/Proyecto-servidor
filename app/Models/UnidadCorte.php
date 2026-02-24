<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class UnidadCorte extends Model
{
    use Auditable;

    protected $table = 'unidad_corte';
    protected $primaryKey = 'id_unidad_corte';
    public $timestamps = false;
    protected $guarded = [];
}
