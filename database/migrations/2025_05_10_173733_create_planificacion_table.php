<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        schema::create('detalle_actividad', function (Blueprint $table) {
            $table->id('detalle_id');
            $table->string('corte', 1);
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('2');
        });

        schema::create('detalle_planificacion', function (Blueprint $table) {
            $table->id('detalle_planificacion_id');
            $table->unsignedBigInteger('planificacion_id');
            $table->unsignedBigInteger('detalle_id');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('planificacion_id')->references('planificacion_id')->on('planificacion');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
        });

        schema::create('contenidos', function (Blueprint $table) {
            $table->id('contenido_id');
            $table->string('titulo');
            $table->text('descripcion')->nullable();
            $table->string('unidad_codigo', 7)->nullable(); // Added nullable as we deleted units table
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('detalle_contenidos', function (Blueprint $table) {
            $table->id('detalle_contenido_id');
            $table->unsignedBigInteger('detalle_id');
            $table->unsignedBigInteger('contenido_id');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
            $table->foreign('contenido_id')->references('contenido_id')->on('contenidos');
        });


        schema::create('indicadores_logros', function (Blueprint $table) {
            $table->id('indicador_id');
            $table->text('indicador');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('contenido_indicadores', function (Blueprint $table) {
            $table->id('contenido_indicador_id');
            $table->unsignedBigInteger('detalle_contenido_id');
            $table->unsignedBigInteger('indicador_id');
            $table->foreign('detalle_contenido_id')->references('detalle_contenido_id')->on('detalle_contenidos');
            $table->foreign('indicador_id')->references('indicador_id')->on('indicadores_logros');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('recursos', function (Blueprint $table) {
            $table->id('recurso_id');
            $table->text('recurso');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('detalle_recursos', function (Blueprint $table) {
            $table->id('detalle_recurso_id');
            $table->unsignedBigInteger('detalle_id');
            $table->unsignedBigInteger('recurso_id');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
            $table->foreign('recurso_id')->references('recurso_id')->on('recursos');
        });

        schema::create('estrategias_pedagogicas', function (Blueprint $table) {
            $table->id('estrategia_id');
            $table->text('estrategia');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('detalle_estrategias', function (Blueprint $table) {
            $table->id('detalle_estrategia_id');
            $table->unsignedBigInteger('detalle_id');
            $table->unsignedBigInteger('estrategia_id');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
            $table->foreign('estrategia_id')->references('estrategia_id')->on('estrategias_pedagogicas');
        });

        schema::create('motivos_rechazo', function (Blueprint $table) {
            $table->id('motivo_id');
            $table->unsignedBigInteger('detalle_id');
            $table->text('motivo');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
        });

        schema::create('evaluaciones', function (Blueprint $table) {
            $table->id('evaluacion_id');
            $table->text('evaluacion');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('tecnicas', function (Blueprint $table) {
            $table->id('tecnica_id');
            $table->text('tecnica');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });


        schema::create('detalle_evaluacion', function (Blueprint $table) {
            $table->id('detalle_evaluacion_id');
            $table->unsignedBigInteger('evaluacion_id');
            $table->unsignedBigInteger('detalle_id');
            $table->unsignedBigInteger('tecnica_id');
            $table->float('ponderacion');
            $table->date('fecha_evaluacion');
            $table->enum('forma_participacion', ['1', '2', '3'])->default('1');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('evaluacion_id')->references('evaluacion_id')->on('evaluaciones');
            $table->foreign('detalle_id')->references('detalle_id')->on('detalle_actividad');
            $table->foreign('tecnica_id')->references('tecnica_id')->on('tecnicas');
        });

        schema::create('bibliografias', function (Blueprint $table) {
            $table->id('bibliografia_id');
            $table->text('bibliografia');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('detalle_bibliografia', function (Blueprint $table) {
            $table->id('detalle_bibliografia_id');
            $table->unsignedBigInteger('planificacion_id');
            $table->unsignedBigInteger('bibliografia_id');
            $table->timestamp('fecha_creacion');
            $table->enum('estatus', ['1', '2', '3'])->default('1');
            $table->foreign('planificacion_id')->references('planificacion_id')->on('planificacion');
            $table->foreign('bibliografia_id')->references('bibliografia_id')->on('bibliografias');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
    }
};
