<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{EstudiantesController, EducadorasController, NivelesController, EventosController};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// get: index o show
// post: store
// delete: destroy
// patch o put: update

Route::apiResource('/estudiantes',EstudiantesController::class);
//Route::apiResource('/estudiantes',NivelesController::class);
Route::apiResource('/educadoras',EducadorasController::class);
//Route::apiResource('/educadoras',NivelesController::class);
//Route::apiResource('/estudiantes',EventosController::class);

//Para probar en postman 
Route::apiResource('/niveles',NivelesController::class);
Route::apiResource('/eventos',EventosController::class);
