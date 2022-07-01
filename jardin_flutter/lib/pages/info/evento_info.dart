import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_estudiante_page.dart';
import 'package:jardin_flutter/pages/editar/editar_evento_page.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventoInfoPage extends StatefulWidget {
  int idEvento;
  EventoInfoPage(this.idEvento, {Key? key}) : super(key: key);

  @override
  State<EventoInfoPage> createState() => _EventoInfoPageState();
}

class _EventoInfoPageState extends State<EventoInfoPage> {
  final formKey = GlobalKey<FormState>();

  /////PARA DROPDOWNBUTTON/////
  int alumnId = 1;
  String dropdownCausa = 'Retiro';
  List alumnList = List.empty();
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future getAllEstudiantes() async {
    var uri = Uri.parse('$apiURL/estudiantes');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      //return json.decode(respuesta.body);
      var jsonData = jsonDecode(respuesta.body);
      setState(() {
        alumnList = jsonData;
        alumnId = alumnList[0]['id'];
      });
    } else {
      return [];
    }
    //print(nivelesList);
  }

  @override
  void initState() {
    super.initState();
    getAllEstudiantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
        title: Text(
          'Información Estudiante',
          style: TextStyle(color: Color.fromARGB(255, 143, 195, 80)),
        ),
      ),
      body: FutureBuilder(
        future: Providers().getEvento(widget.idEvento),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          String idText = data['id'].toString();
          String nombreText = data['nombre'];
          String descripcionText = data['descripcion'];
          String fechaText = data['fecha'];
          String id_estudianteText = data['estudiantes_id'];

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text('ID Evento: ' + idText),
                  Text('Nombre: ' + nombreText),
                  Text('Descripcion: ' + descripcionText),
                  Text('Edad: ' + fechaText),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return EventoEditarPage(data['id']);
                        });

                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 143, 195, 80),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
