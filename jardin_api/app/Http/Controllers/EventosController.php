<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;
use App\Http\Requests\EventosRequest;

class EventosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Evento::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
   
    public function store(EventosRequest $request)
    {
        $evento = new Evento();
        $evento->nombre = $request->nombre;
        $evento->descripcion = $request -> descripcion;
        $evento->fecha = $request -> fecha;
        $evento->hora = $request -> hora;
        $evento -> estudiantes_id = $request-> estudiantes_id;
        $evento->save();
        return $evento;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
    public function show($evento)
    {
        //return $evento;
        //Evento::where('id', $evento);
        return $evento;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
   
    public function update(EventosRequest $request, Evento $evento)
    {
        $evento->nombre = $request->nombre;
        $evento->descripcion = $request -> descripcion;
        $evento->fecha = $request -> fecha;
        $evento -> estudiantes_id = $request-> estudiantes_id;
        $evento->save();
        return $evento;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
    public function destroy($evento)
    {
        Evento::where('id', $evento)->delete();
    }
}
