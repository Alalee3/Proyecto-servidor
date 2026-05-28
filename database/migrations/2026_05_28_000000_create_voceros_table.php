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
        Schema::create('vocero', function (Blueprint $table) {
            $table->id('id_vocero');
            $table->string('id_estudiante')->comment('Cédula del estudiante (PK en la DB externa)');
            $table->integer('id_seccion')->comment('Código de la sección en la DB externa');
            $table->integer('id_pnf')->comment('Código del programa/PNF en la DB externa');
            $table->integer('id_coordinador')->comment('ID o código de usuario del coordinador que asignó al vocero');
            $table->timestamps();

            // Garantizar que solo haya un vocero principal por sección
            $table->unique('id_seccion', 'unique_vocero_seccion');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vocero');
    }
};
