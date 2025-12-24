<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        schema::create('planificacion', function (Blueprint $table) {
            $table->id('planificacion_id');
            $table->unsignedBigInteger('docente_id');
            // Removed seccion_id and unidad_codigo
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('2');
            $table->foreign('docente_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('planificacion');
    }
};
