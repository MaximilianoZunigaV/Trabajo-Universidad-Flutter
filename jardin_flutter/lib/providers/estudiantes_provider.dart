import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Providers {
  final String apiURL = 'http://10.0.2.2:8000/api';

  //lista de estudiantes

  Future<List<dynamic>> getEstudiantes() async {
    var uri = Uri.parse('$apiURL/estudiantes');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //lista de educadoras
  Future<List<dynamic>> getEducadoras() async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //borrar estudiantes
  Future<bool> EstudiantesBorrar(String id_estudiante) async {
    var uri = Uri.parse('$apiURL/estudiantes/$id_estudiante');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
