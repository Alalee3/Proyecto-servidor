<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SemanaEvento extends Model
{
    protected $table = 'semana_evento';
    protected $primaryKey = 'id_semana_evento';
    public $timestamps = false;
    protected $guarded = [];

    public function evento()
    {
        return $this->belongsTo(Evento::class, 'id_evento');
    }
}
