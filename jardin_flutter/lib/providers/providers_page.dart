//import 'dart:collection';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Providers {
  final String apiURL = 'http://10.0.2.2:8000/api';

  /////////////////////ESTUDIANTES///////////////////////////

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

  //Agregar estudiante
  Future<LinkedHashMap<String, dynamic>> estudiantesAgregar(
      String cod_estudiante,
      String nombre,
      String apellido,
      int edad,
      int niveles_id) async {
    var uri = Uri.parse('$apiURL/estudiantes');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'cod_estudiante': cod_estudiante,
          'nombre': nombre,
          'apellido': apellido,
          'edad': edad,
          'niveles_id': niveles_id,
        }));

    return json.decode(respuesta.body);
  }

  //borrar estudiantes
  Future<bool> estudiantesBorrar(String cod_estudiante) async {
    var uri = Uri.parse('$apiURL/estudiantes/$cod_estudiante');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  //lista de Niveles
  Future<List<dynamic>> getNiveles() async {
    var uri = Uri.parse('$apiURL/niveles');
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

  //lista de eventos
  Future<List<dynamic>> getEventos() async {
    var uri = Uri.parse('$apiURL/eventos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}
