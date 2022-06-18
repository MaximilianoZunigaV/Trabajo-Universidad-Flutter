<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('estudiantes', function (Blueprint $table) {

            // Se le puse id(); para quitar error en evento, tratar de cambiar mas adelante

            //$table->string('cod_estudiante')->primary();
            $table->string('cod_estudiante')->primary();
            $table->string('nombre');
            $table->string('apellido');
            $table->integer('edad');
            $table->softDeletes();
            // $table->timestamps();
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('estudiantes');
    }
};
