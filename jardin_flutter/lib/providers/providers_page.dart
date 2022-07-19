import 'dart:async';
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
      String nombre, String apellido, int edad, int niveles_id) async {
    var uri = Uri.parse('$apiURL/estudiantes');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'apellido': apellido,
          'edad': edad,
          'niveles_id': niveles_id,
        }));

    return json.decode(respuesta.body);
  }

  //datos de 1 Estudiante
  Future<LinkedHashMap<String, dynamic>> getEstudiante(int idEstudiante) async {
    var uri = Uri.parse('$apiURL/estudiantes/$idEstudiante');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar estudiante
  Future<LinkedHashMap<String, dynamic>> estudianteEditar(
      int id, String nombre, String apellido, int edad, int niveles_id) async {
    var uri = Uri.parse('$apiURL/estudiantes/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'apellido': apellido,
          'edad': edad,
          'niveles_id': niveles_id,
        }));

    return json.decode(respuesta.body);
  }

  //borrar estudiantes
  Future<bool> estudianteBorrar(String cod_estudiante) async {
    var uri = Uri.parse('$apiURL/estudiantes/$cod_estudiante');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  /////////////////NIVELES////////////////////////////

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

  //Agregar Nivel
  Future<LinkedHashMap<String, dynamic>> nivelAgregar(String nombre) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));

    return json.decode(respuesta.body);
  }

  //Obtener 1 nivel
  Future<LinkedHashMap<String, dynamic>> getNivel(int idNivel) async {
    var uri = Uri.parse('$apiURL/niveles/$idNivel');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar nivel
  Future<LinkedHashMap<String, dynamic>> NivelEditar(
      int id, String nombre) async {
    var uri = Uri.parse('$apiURL/niveles/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));

    return json.decode(respuesta.body);
  }

  //borrar nivel
  Future<bool> nivelBorrar(String id_nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$id_nivel');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

////////////////////////EDUCADORAS////////////////////////
  ///
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

  //agregar educadora
  Future<LinkedHashMap<String, dynamic>> educadoraAgregar(
      String nombre, String apellido, String email, int niveles_id) async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'apellido': apellido,
          'email': email,
          'niveles_id': niveles_id,
        }));

    return json.decode(respuesta.body);
  }

  //retorna datos de 1 educadora
  Future<LinkedHashMap<String, dynamic>> getEducadora(int id) async {
    var uri = Uri.parse('$apiURL/educadoras/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar educadora
  Future<LinkedHashMap<String, dynamic>> educadoraEditar(int id, String nombre,
      String apellido, String email, int niveles_id) async {
    var uri = Uri.parse('$apiURL/educadoras/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'apellido': apellido,
          'email': email,
          'niveles_id': niveles_id,
        }));

    return jsonDecode(respuesta.body);
  }

  //borrar educadora
  Future<bool> educadoraBorrar(String cod_educadora) async {
    var uri = Uri.parse('$apiURL/educadoras/$cod_educadora');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

////////////////////////EVENTOS///////////////////////////

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

  //agregar evento
  Future<LinkedHashMap<String, dynamic>> eventoAgregar(String nombre,
      String descripcion, String fecha, String hora, int estudiantes_id) async {
    var uri = Uri.parse('$apiURL/eventos');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'descripcion': descripcion,
          'fecha': fecha,
          'hora': hora,
          'estudiantes_id': estudiantes_id,
        }));
    return json.decode(respuesta.body);
  }

  //retorna datos de 1 evento
  //Este provider no funciona, no pudimos encontrar una solucion
  Future<LinkedHashMap<String, dynamic>> getEvento(int id) async {
    var uri = Uri.parse('$apiURL/eventos/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar evento
  Future<LinkedHashMap<String, dynamic>> eventoEditar(int id, String nombre,
      String descripcion, String fecha, String hora, int estudiantes_id) async {
    var uri = Uri.parse('$apiURL/eventos/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'descripcion': descripcion,
          'fecha': fecha,
          'hora': hora,
          'niveles_id': estudiantes_id,
        }));

    return json.decode(respuesta.body);
  }

  //evento borrar
  Future<bool> eventoBorrar(String cod_evento) async {
    var uri = Uri.parse('$apiURL/eventos/$cod_evento');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
