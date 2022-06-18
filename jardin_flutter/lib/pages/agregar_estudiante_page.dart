import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';

class AgregarEstudiante extends StatefulWidget {
  AgregarEstudiante({Key? key}) : super(key: key);

  @override
  State<AgregarEstudiante> createState() => _AgregarEstudianteState();
}

class _AgregarEstudianteState extends State<AgregarEstudiante> {
  final formKey = GlobalKey<FormState>();

  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController EdadCtrl = TextEditingController();
  TextEditingController NivelCtrl = TextEditingController();

  String errCodigo = '';
  String errNombre = '';
  String errApellido = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiante'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(),
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(labelText: 'Codigo'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCodigo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre'),
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
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errApellido,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: EdadCtrl,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: NivelCtrl,
                decoration: InputDecoration(labelText: 'Nivel'),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Estudiante'),
                  onPressed: () async {
                    int edad = int.tryParse(EdadCtrl.text) ?? 0;
                    int niveles_id = int.tryParse(NivelCtrl.text) ?? 0;

                    var respuesta = await Providers().estudiantesAgregar(
                      codigoCtrl.text.trim(),
                      nombreCtrl.text.trim(),
                      apellidoCtrl.text.trim(),
                      edad,
                      niveles_id,
                      //BigInt.from(nivel), //transformar a BigInt
                    );

                    if (respuesta['message'] != null) {
                      //codigo
                      if (respuesta['errors']['cod_estudiante'] != null) {
                        errCodigo = respuesta['errors']['cod_estudiante'][0];
                      }

                      //nombre
                      if (respuesta['errors']['nombre'] != null) {
                        errNombre = respuesta['errors']['nombre'][0];
                      }

                      //apeliido
                      if (respuesta['errors']['apellido'] != null) {
                        errApellido = respuesta['errors']['apellido'][0];
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
