<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class IndicadorLogro extends Model
{
    use Auditable;

    protected $table = 'indicador_logro';
    protected $primaryKey = 'id_indicador_logro';
    public $timestamps = false;
    protected $guarded = [];
}
