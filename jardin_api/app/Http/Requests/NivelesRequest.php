<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NivelesRequest extends FormRequest
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
          
            'nombre' => 'required|unique:niveles,nombre',
        ];
    }

    public function messages(){
        return [
            'nombre.unique' => 'El nivel :input ya existe en el sistema',
            'nombre.required' => 'Indique nombre del nivel',
           
        ];
    }
}
