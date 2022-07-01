import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EducadoraEditarPage extends StatefulWidget {
  int idEdu;
  EducadoraEditarPage(this.idEdu, {Key? key}) : super(key: key);

  @override
  State<EducadoraEditarPage> createState() => _EducadoraEditarPageState();
}

class _EducadoraEditarPageState extends State<EducadoraEditarPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  String errNombre = '';
  String errApellido = '';
  String errEmail = '';

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
          'Editar Educadora',
          style: TextStyle(color: Color.fromARGB(255, 143, 195, 80)),
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
          String nombreText = data['nombre'];
          String apellidoText = data['apellido'];
          String emailText = data['email'];

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: InputDecoration(
                        labelText: 'Nombre', hintText: nombreText),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errNombre,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextFormField(
                    controller: apellidoCtrl,
                    decoration: InputDecoration(
                        labelText: 'Apellido', hintText: apellidoText),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errApellido,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: emailText),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errEmail,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Text(''),
                  Text(
                    'Nivel',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  DropdownButton(
                      //Nuevo Widget :D //Agregar para que sea con base de datos
                      isExpanded: true,
                      value: dropdownValue,
                      hint: Text('Seleccione un nivel'),
                      onChanged: (val) {
                        setState(() {
                          int newVal = int.tryParse(val.toString()) ??
                              0; // Transformando el val a String y luego a int para que el valor que tome sea el id
                          dropdownValue = newVal;
                        });
                      },
                      items: nivelesList.map((niveles) {
                        return DropdownMenuItem(
                          value: niveles['id'], //toma el valor id
                          child: Text(
                              niveles['nombre']), //muesta en pantalla el nombre
                        );
                      }).toList()),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () async {
                        var respuesta = await Providers().educadoraEditar(
                            widget.idEdu,
                            nombreCtrl.text.trim(),
                            apellidoCtrl.text.trim(),
                            emailCtrl.text.trim(),
                            dropdownValue);
                        if (respuesta['message'] != null) {
                          //nombre
                          if (respuesta['errors']['nombre'] != null) {
                            errNombre = respuesta['errors']['nombre'][0];
                          }

                          //apeliido
                          if (respuesta['errors']['apellido'] != null) {
                            errApellido = respuesta['errors']['apellido'][0];
                          }
                          //edad
                          if (respuesta['errors']['email'] != null) {
                            errEmail = respuesta['errors']['email'][0];
                          }
                          setState(() {});
                          return;
                        }

                        Navigator.pop(context);
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
