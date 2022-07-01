import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_estudiante_page.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EstudianteInfoPage extends StatefulWidget {
  int idAlumn;
  EstudianteInfoPage(this.idAlumn, {Key? key}) : super(key: key);

  @override
  State<EstudianteInfoPage> createState() => _EstudianteInfoPageState();
}

class _EstudianteInfoPageState extends State<EstudianteInfoPage> {
  final formKey = GlobalKey<FormState>();

  /////PARA DROPDOWNBUTTON/////
  int dropdownValue =
      0; //se debe cambiar este valor por el primer elemento de la lista de Niveles
  List nivelesList = List.empty();
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future getAllNiveles() async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      //return json.decode(respuesta.body);
      var jsonData = jsonDecode(respuesta.body);
      setState(() {
        nivelesList = jsonData;
        dropdownValue = nivelesList[0]['id'];
      });
    } else {
      return [];
    }
    //print(nivelesList);
  }

  @override
  void initState() {
    super.initState();
    getAllNiveles();
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
        future: Providers().getEstudiante(widget.idAlumn),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          String idText = data['id'].toString();
          String nombreText = data['nombre'];
          String apellidoText = data['apellido'];
          String edadText = data['edad'].toString();

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text('General',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Divider(),
                  ListTile(title: Text('ID Estudiante :  ' + idText)),
                  ListTile(title: Text('Nombre :  ' + nombreText)),
                  ListTile(title: Text('Apellido :  ' + apellidoText)),
                  ListTile(title: Text('Edad :  ' + edadText + ' años')),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return EstudianteEditarPage(data['id']);
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
