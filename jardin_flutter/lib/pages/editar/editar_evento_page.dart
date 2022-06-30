import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventoEditarPage extends StatefulWidget {
  int idEvento;
  EventoEditarPage(this.idEvento, {Key? key}) : super(key: key);

  @override
  State<EventoEditarPage> createState() => _EventoEditarPageState();
}

class _EventoEditarPageState extends State<EventoEditarPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  //TextEditingController edadCtrl = TextEditingController();

  String errDescripcion = '';

  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');

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
          'Editar Estudiante',
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
          //idCtrl.text = data['id'].toString();
          String nombreText = data['nombre'];
          descripcionCtrl.text = data['descripcion'];
          String fechaText = data['fecha'];
          //int eventoId = int.tryParse(idCtrl.text.trim()) ?? 0;
          //edadCtrl.text = data['edad'].toString();

          return Form(
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
                  Row(
                    children: [
                      Text('Fecha Actual: ', style: TextStyle(fontSize: 16)),
                      Text(ffecha.format(fechaSeleccionada),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                  Container(),
                  Text(''),
                  Text(
                    'Nivel',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  DropdownButton(
                      isExpanded: true,
                      value: alumnId,
                      hint: Text('Seleccione un estudiante'),
                      onChanged: (val) {
                        setState(() {
                          int newVal = int.tryParse(val.toString()) ??
                              0; // Transformando el val a String y luego a int para que el valor que tome sea el id
                          alumnId = newVal;
                        });
                      },
                      items: alumnList.map((alumnos) {
                        return DropdownMenuItem(
                          value: alumnos['id'], //toma el valor id
                          child: Text(
                              alumnos['nombre']), //muesta en pantalla el nombre
                        );
                      }).toList()),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        Providers().eventoEditar(
                            widget.idEvento,
                            dropdownCausa,
                            descripcionCtrl.text.trim(),
                            fechaSeleccionada.toString(),
                            alumnId);

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
