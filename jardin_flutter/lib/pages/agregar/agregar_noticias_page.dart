import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin_flutter/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NoticiasAgregar extends StatefulWidget {
  NoticiasAgregar({Key? key}) : super(key: key);

  @override
  State<NoticiasAgregar> createState() => _NoticiasAgregarState();
}

class _NoticiasAgregarState extends State<NoticiasAgregar> {
  //fecha
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  //hora
  DateTime horaSeleccionada = DateTime.now();
  var fhora = DateFormat('hh:mm');

  static final DateTime hnow = DateTime.now();
  static final DateFormat hformatter = DateFormat('hh:mm');
  final String hformatted = hformatter.format(hnow);

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreCtrl = TextEditingController();
    TextEditingController textoCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Noticia'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  labelText: 'Titulo Noticia',
                ),
              ),
              TextFormField(
                controller: textoCtrl,
                decoration: InputDecoration(
                  labelText: 'Texto',
                ),
              ),
              Text(''),
              Row(
                children: [
                  Text('Fecha Actual: ', style: TextStyle(fontSize: 16)),
                  Text(ffecha.format(now),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(''),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Noticia'),
                  onPressed: () {
                    String nombre = nombreCtrl.text.trim();
                    String texto = textoCtrl.text.trim();
                    String fecha = formatted.trim();
                    String hora = hformatted.trim();
                    FirestoreService()
                        .noticiasAgregar(nombre, texto, fecha, hora);
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
      ),
    );
  }
}
