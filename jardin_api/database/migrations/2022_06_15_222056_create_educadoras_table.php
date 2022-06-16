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
        Schema::create('educadoras', function (Blueprint $table) {
            $table->string('cod_educadora')->primary();
            $table->string('nombre');
            $table->string('apellido');
            $table->string('email');
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
        Schema::dropIfExists('educadoras');
    }
};
