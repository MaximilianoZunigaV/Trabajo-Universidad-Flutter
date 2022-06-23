import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarEvento extends StatefulWidget {
  AgregarEvento({Key? key}) : super(key: key);

  @override
  State<AgregarEvento> createState() => _AgregarEventoState();
}

class _AgregarEventoState extends State<AgregarEvento> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();

  String errNombre = '';
  String errDescripcion = '';
  String errFecha = '';

  /////PARA DROPDOWNBUTTON/////
  int dropdownAlumn = 1;
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
  ////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evento'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              //Container(),
              Text(''),
              Text('Causa de Evento',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              DropdownButton(
                  isExpanded: true,
                  value: dropdownCausa,
                  hint: Text('Seleccione Causa de Evento'),
                  //icon: Icon(Icons.arrow_downward),
                  //style: TextStyle(color: Colors.green),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.grey.shade300,
                  // ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownCausa = newValue!;
                    });
                  },
                  items: <String>[
                    'Retiro',
                    'Accidente',
                    'Cambio de Nivel',
                    'Otra Causa'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              TextFormField(
                controller: descripcionCtrl,
                decoration: InputDecoration(labelText: 'Descripcion'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errDescripcion,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: fechaCtrl,
                decoration: InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errFecha,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Text(
                'Estudiante',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              DropdownButton(
                  //Nuevo Widget :D //Agregar para que sea con base de datos
                  isExpanded: true,
                  value: dropdownAlumn,
                  hint: Text('Seleccione un estudiante'),
                  onChanged: (val) {
                    setState(() {
                      int newVal = int.tryParse(val.toString()) ?? 0;
                      dropdownAlumn = newVal;
                    });
                  },
                  items: alumnList.map((estudiantes) {
                    return DropdownMenuItem(
                      value: estudiantes['id'], //toma el codigo del estudiante
                      child: Text(
                          estudiantes['nombre']), //muesta en pantalla el nombre
                    );
                  }).toList()),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Evento'),
                  onPressed: () async {
                    var respuesta = await Providers().eventoAgregar(
                      dropdownCausa,
                      descripcionCtrl.text.trim(),
                      fechaCtrl.text.trim(),
                      dropdownAlumn, //toma el valor de la id seleccionada (desde el DropDownButton),
                      //BigInt.from(nivel), //transformar a BigInt
                    );

                    if (respuesta['message'] != null) {
                      //codigo
                      if (respuesta['errors']['fecha'] != null) {
                        errFecha = respuesta['errors']['fecha'][0];
                      }

                      //nombre
                      if (respuesta['errors']['nombre'] != null) {
                        errNombre = respuesta['errors']['nombre'][0];
                      }

                      //apeliido
                      if (respuesta['errors']['descripcion'] != null) {
                        errDescripcion = respuesta['errors']['descripcion'][0];
                      }
                      setState(() {});
                      return;
                    }

                    Navigator.pop(context);
                  }, //Fuera de onPressed
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 143, 195, 80),
                  ), //Cambiar color del boton
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
