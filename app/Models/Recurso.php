<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Recurso extends Model
{
    use Auditable;

    protected $table = 'recurso';
    protected $primaryKey = 'id_recurso';
    public $timestamps = false;
    protected $guarded = [];
}
