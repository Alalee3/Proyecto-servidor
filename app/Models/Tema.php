<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Tema extends Model
{
    use Auditable;

    protected $table = 'tema_unidad';
    protected $primaryKey = 'id_tema_unidad';
    public $timestamps = false;
    protected $guarded = [];
}
