<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Objetivo extends Model
{
    use Auditable;

    protected $table = 'objetivo';
    protected $primaryKey = 'id_objetivo';
    public $timestamps = false;
    protected $guarded = [];
}
