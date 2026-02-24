<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Pnf extends Model
{
    use Auditable;

    protected $table = 'pnf';
    protected $primaryKey = 'id_pnf';
    public $timestamps = false;
    protected $guarded = [];
}
