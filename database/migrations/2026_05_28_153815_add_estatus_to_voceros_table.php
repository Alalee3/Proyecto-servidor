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
        Schema::table('vocero', function (Blueprint $table) {
            $table->char('estatus', 1)->default('A')->comment('A: Activo, I: Inactivo')->after('id_coordinador');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('vocero', function (Blueprint $table) {
            $table->dropColumn('estatus');
        });
    }
};
