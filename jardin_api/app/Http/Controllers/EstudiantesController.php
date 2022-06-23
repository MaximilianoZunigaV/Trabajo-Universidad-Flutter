<?php

namespace App\Http\Controllers;

use App\Models\Estudiante;
use Illuminate\Http\Request;

class EstudiantesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Estudiante::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function store(Request $request)
    {
        $estudiante = new Estudiante();
        $estudiante -> nombre = $request -> nombre;
        $estudiante -> apellido = $request->apellido;
        $estudiante -> edad = $request-> edad;
        $estudiante -> niveles_id = $request-> niveles_id;
        $estudiante->save();

        return $estudiante;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Estudiante  $estudiante
     * @return \Illuminate\Http\Response
     */
    public function show(Estudiante $estudiante)
    {
        return $estudiante;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Estudiante  $estudiante
     * @return \Illuminate\Http\Response
     */
  
    public function update(Request $request, Estudiante $estudiante)
    {   
        $estudiante -> nombre = $request -> nombre;
        $estudiante -> apellido = $request->apellido;
        $estudiante -> edad = $request-> edad;
        $estudiante -> niveles_id = $request-> niveles_id;
        $estudiante->save();

        return $estudiante;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Estudiante  $estudiante
     * @return \Illuminate\Http\Response
     */
    public function destroy($estudiante)
    {
        Estudiante::where('id', $estudiante) -> delete();
    }
}
