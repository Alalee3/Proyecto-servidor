<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Evento extends Model
{
    use Auditable;

    protected $table = 'evento';
    protected $primaryKey = 'id_evento';
    public $timestamps = false;
    protected $guarded = [];
}
