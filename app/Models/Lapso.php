<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Lapso extends Model
{
    use Auditable;

    protected $table = 'lapso_academico';
    protected $primaryKey = 'id_lapso_academico';
    public $timestamps = false;
    protected $guarded = [];
}
