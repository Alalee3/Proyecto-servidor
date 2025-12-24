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
        Schema::create('users', function (Blueprint $table) {
            $table->id('id');
            $table->tinyText('name');
            $table->tinyText('apellido');
            $table->string('cedula', 10)->unique();
            $table->string('email', 50)->unique();
            $table->string('telefono', 20)->unique()->nullable();
            $table->string('theme', 10)->nullable();
            $table->text('password');
            $table->rememberToken();
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('roles', function (blueprint $table) {
            $table->id('rol_id');
            $table->tinyText('acceso');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        schema::create('usuario_roles', function (blueprint $table) {
            $table->id('usuario_rol_id');
            $table->unsignedBigInteger('usuario_id');
            $table->unsignedBigInteger('rol_id');
            $table->foreign('usuario_id')->references('id')->on('users');
            $table->foreign('rol_id')->references('rol_id')->on('roles');
            $table->timestamp('fecha_creacion')->useCurrent();
            $table->enum('estatus', ['1', '2', '3'])->default('1');
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        schema::dropIfExists('roles');
        schema::dropIfExists('usuario_roles');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};
