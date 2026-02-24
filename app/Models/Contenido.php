<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Contenido extends Model
{
    use Auditable;

    protected $table = 'contenido';
    protected $primaryKey = 'id_contenido';
    public $timestamps = false;
    protected $guarded = [];
}
