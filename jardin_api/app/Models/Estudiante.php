<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Estudiante extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'estudiantes';
    // protected $primaryKey = 'cod_estudiante';
    // public $incrementing = false;
    // protected $keyType = 'string';
    public $timestamps = false;


    public function nivel(){
        return $this->belongsTo(Nivel::class); 
        //Haciendo referencia al modelo Nivel
    }

    public function eventos(){
        return $this->hasMany(evento::class);
    }



}
