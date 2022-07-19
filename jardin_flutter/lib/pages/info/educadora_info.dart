import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_educadora_page.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EducadoraInfoPage extends StatefulWidget {
  int idEdu;
  EducadoraInfoPage(this.idEdu, {Key? key}) : super(key: key);

  @override
  State<EducadoraInfoPage> createState() => _EducadoraInfoPageState();
}

class _EducadoraInfoPageState extends State<EducadoraInfoPage> {
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
      backgroundColor: Color.fromARGB(255, 229, 206, 238),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
        title: Text(
          'Información Educadora',
        ),
      ),
      body: FutureBuilder(
        future: Providers().getEducadora(widget.idEdu),
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
          String emailText = data['email'];

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
                  ListTile(title: Text('ID Educadora :  ' + idText)),
                  ListTile(title: Text('Nombre :  ' + nombreText)),
                  ListTile(title: Text('Apellido :  ' + apellidoText)),
                  ListTile(title: Text('Email :  ' + emailText)),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return EducadoraEditarPage(data['id']);
                        });

                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 168, 148, 206),
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
