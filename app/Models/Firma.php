<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Auditable;

class Firma extends Model
{
    use Auditable;

    protected $table = 'firma';
    protected $primaryKey = 'id_firma';
    public $timestamps = false;
    protected $guarded = [];

    public $moduleName = 'Firmas';

    /**
     * Campos a excluir de la bitácora (evita errores con datos binarios).
     */
    public $auditExclude = ['foto_firma'];

    /**
     * Relación con el usuario.
     */
    public function usuario()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'usu_codigo');
    }

    /**
     * Obtener la imagen de la firma en base64 para mostrar en vistas.
     */
    public function getFotoBase64Attribute()
    {
        if (!$this->foto_firma) {
            return null;
        }
        return 'data:image/png;base64,' . base64_encode($this->foto_firma);
    }
}
