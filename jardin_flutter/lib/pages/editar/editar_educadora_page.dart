import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EducadoraEditarPage extends StatefulWidget {
  String codEducadora;
  EducadoraEditarPage(this.codEducadora, {Key? key}) : super(key: key);

  @override
  State<EducadoraEditarPage> createState() => _EducadoraEditarPageState();
}

class _EducadoraEditarPageState extends State<EducadoraEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

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
        title: Text('Editar Educadora'),
      ),
      body: FutureBuilder(
        future: Providers().getEducadora(widget.codEducadora),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          codigoCtrl.text = data['cod_educadora'];
          nombreCtrl.text = data['nombre'];
          apellidoCtrl.text = data['apellido'];
          emailCtrl.text = data['email'];

          return Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: codigoCtrl,
                  decoration: InputDecoration(labelText: 'Codigo'),
                ),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: apellidoCtrl,
                  decoration: InputDecoration(labelText: 'Apellido'),
                ),
                TextFormField(
                  controller: emailCtrl,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                Text(''),
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
                    onPressed: () {
                      Providers().educadoraEditar(
                        widget.codEducadora,
                        codigoCtrl.text.trim(),
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        dropdownValue,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
