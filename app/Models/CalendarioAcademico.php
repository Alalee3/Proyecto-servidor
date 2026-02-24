<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class CalendarioAcademico extends Model
{
    use Auditable;

    protected $table = 'calendario_academico';
    protected $primaryKey = 'id_calendario_academico';
    public $timestamps = false;
    protected $guarded = [];
}
