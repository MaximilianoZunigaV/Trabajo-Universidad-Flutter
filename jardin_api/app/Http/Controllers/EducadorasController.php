<?php

namespace App\Http\Controllers;

use App\Models\Educadora;
use Illuminate\Http\Request;
use App\Http\Requests\EducadorasRequest;

class EducadorasController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Educadora::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function store(EducadorasRequest $request)
    {
        $educadora = new Educadora();
        $educadora -> nombre = $request -> nombre;
        $educadora -> apellido = $request->apellido;
        $educadora -> email = $request-> email;
        $educadora -> niveles_id = $request-> niveles_id;
        $educadora->save();

        return $educadora;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Educadora  $educadora
     * @return \Illuminate\Http\Response
     */
    public function show(Educadora $educadora)
    {
        return $educadora;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Educadora  $educadora
     * @return \Illuminate\Http\Response
     */
    public function edit(Educadora $educadora)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Educadora  $educadora
     * @return \Illuminate\Http\Response
     */
    public function update(EducadorasRequest $request, Educadora $educadora)
    {
        $educadora -> nombre = $request -> nombre;
        $educadora -> apellido = $request->apellido;
        $educadora -> email = $request-> email;
        $educadora -> niveles_id = $request-> niveles_id;
        $educadora->save();

        return $educadora;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Educadora  $educadora
     * @return \Illuminate\Http\Response
     */
    public function destroy($educadora)
    {
        Educadora::where('id', $educadora) -> delete();
    }
}
