import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AgregarEvento extends StatefulWidget {
  AgregarEvento({Key? key}) : super(key: key);

  @override
  State<AgregarEvento> createState() => _AgregarEventoState();
}

class _AgregarEventoState extends State<AgregarEvento> {
  final formKey = GlobalKey<FormState>();

  TextEditingController descripcionCtrl = TextEditingController();

  String errDescripcion = '';

  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');
  //String afecha = ffecha.format(fechaSeleccionada);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  // //fecha
  // var fhora = DateFormat('hh-mm');
  // static final DateTime ahora = DateTime.now();
  // static final DateFormat formato = DateFormat('hh-mm');

  //Obtener el valor de id (para dropdownValue)

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
        title: Text('Evento'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
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
              Row(
                children: [
                  Text('Fecha Actual: ', style: TextStyle(fontSize: 16)),
                  Text(ffecha.format(fechaSeleccionada),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  TextButton(
                      child: Icon(MdiIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        ).then((fecha) {
                          fechaSeleccionada = fecha ?? fechaSeleccionada;
                        });
                      }),
                ],
              ),
              Text(''),
              Text(
                'Estudiante',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              DropdownButton(
                  //Nuevo Widget :D //Agregar para que sea con base de datos
                  isExpanded: true,
                  value: alumnId,
                  hint: Text('Seleccione un estudiante'),
                  onChanged: (val) {
                    setState(() {
                      int newVal = int.tryParse(val.toString()) ?? 0;
                      alumnId = newVal;
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
                      formatted,
                      alumnId, //toma el valor de la id seleccionada (desde el DropDownButton),
                      //BigInt.from(nivel), //transformar a BigInt
                    );

                    if (respuesta['message'] != null) {
                      //descripcion
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
