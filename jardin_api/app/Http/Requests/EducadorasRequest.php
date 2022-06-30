<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EducadorasRequest extends FormRequest
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
            'email' => 'required',
            
        ];
    }
    public function messages(){
        return [
            
            'nombre.required' => 'Indique nombre de la educadora',
            'apellido.required' => 'Indique apellido de la educadora',
            'email.required' => 'Indique email de la educadora',
            
           
        ];
    }
}
