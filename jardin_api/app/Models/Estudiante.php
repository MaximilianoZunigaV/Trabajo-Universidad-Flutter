<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Estudiante extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'estudiantes';
    public $timestamps = false;

    public function nivel(){
        return $this->belongsTo(Nivel::class); 
        //Haciendo referencia al modelo Nivel
    }

    //referencia a estudiante para traer el array de todos los estudiantes que pertenecen al Evento //revisarlo  
    public function estudiantes(){
        return $this->hasMany(Estudiante::class);
    }


}
