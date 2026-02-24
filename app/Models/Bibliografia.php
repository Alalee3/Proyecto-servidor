<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Bibliografia extends Model
{
    use Auditable;

    protected $table = 'bibliografia';
    protected $primaryKey = 'id_bibliografia';
    public $timestamps = false;
    protected $guarded = [];
}
