<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

//REVISAR
//REVISAR
//REVISAR


class Evento extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'eventos';
    public $timestamps = false;

    
    public function estudiante(){
        return $this->belongsTo(Estudiante::class);
    }
}
