<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class DetalleBibliografia extends Model
{
    use Auditable;

    protected $table = 'detalle_bibliografia';
    protected $primaryKey = 'id_detalle_bibliografia';
    public $timestamps = false;
    protected $guarded = [];
}
