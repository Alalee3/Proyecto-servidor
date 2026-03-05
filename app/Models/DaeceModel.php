<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Modelo Base para la integración con la base de datos DAECE.
 * 
 * Este modelo configura automáticamente la conexión secundaria y 
 * desactiva los timestamps de Eloquent para compatibilidad con el esquema externo.
 */
abstract class DaeceModel extends Model
{
    /**
     * El nombre de la conexión que debe utilizar el modelo.
     *
     * @var string|null
     */
    protected $connection = 'external_db';

    /**
     * Indica si el modelo debe gestionar los timestamps (created_at, updated_at).
     *
     * @var bool
     */
    public $timestamps = false;
}
