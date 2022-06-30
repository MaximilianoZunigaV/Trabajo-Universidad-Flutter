<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EstudiantesRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            
            'nombre' => 'required',
            'apellido' => 'required',
            'edad' => 'required|numeric|max:7|min:1',
            
        ];
    }

    public function messages(){
        return [
            
            'nombre.required' => 'Indique nombre del estudiante',
            'apellido.required' => 'Indique apellido del estudiante',
            'edad.required' => 'Indique edad del estudiante',
            'edad.numeric' => 'Edad debe ser número',
            'edad.max' => 'El valor maximo de edad es 7',
            'edad.min' => 'Indique la edad del estudiante',
            //'edad.gte' => 'El valor mínimo de edad es 1',
           
        ];
    }
}
