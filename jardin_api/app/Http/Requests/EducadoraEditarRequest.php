<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EducadoraEditarRequest extends FormRequest
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
            'cod_educadora' => [Rule::unique('educadoras')->ignore($this->educadora->cod_educadora,'cod_educadora'),],
        ];
    }
}
