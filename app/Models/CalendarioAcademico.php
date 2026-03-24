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

    /**
     * Inactiva automáticamente todos los calendarios cuya fecha de fin ya pasó.
     */
    public static function inactivarVencidos()
    {
        return self::where('estatus', '1')
            ->whereDate('dia_fin_calendario_academico', '<', now())
            ->update(['estatus' => '3']);
    }
}
