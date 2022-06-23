<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Nivel extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'niveles';
    // protected $primaryKey = 'id';
    // public $incrementing = true;
    // protected $keyType = 'integer';
    public $timestamps = false;

    public function estudiantes(){
        return $this->hasMany(Estudiante::class);
    }

    public function educadoras(){
        return $this->hasMany(Educadora::class);
    }
}
