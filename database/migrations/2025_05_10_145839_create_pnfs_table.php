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
        Schema::create('pnfs', function (Blueprint $table) {
            $table->id('pnf_id');
            $table->tinytext('nombre');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pnfs');
    }
};
