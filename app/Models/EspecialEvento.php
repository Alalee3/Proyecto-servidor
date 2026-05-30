<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EspecialEvento extends Model
{
    use HasFactory;

    protected $table = 'especial_evento';
    protected $primaryKey = 'id_especial_evento';
    public $timestamps = false; // As per the schema, no timestamps

    protected $fillable = [
        'especial_evento_name',
        'estatus'
    ];

    public function eventos()
    {
        return $this->hasMany(Evento::class, 'id_especial_evento', 'id_especial_evento');
    }
}
