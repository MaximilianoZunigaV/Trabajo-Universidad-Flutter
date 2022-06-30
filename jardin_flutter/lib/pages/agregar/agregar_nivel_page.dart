import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';

class AgregarNivel extends StatefulWidget {
  AgregarNivel({Key? key}) : super(key: key);

  @override
  State<AgregarNivel> createState() => _AgregarNivelState();
}

class _AgregarNivelState extends State<AgregarNivel> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();

  String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel'),
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
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Nivel'),
                  onPressed: () async {
                    var respuesta = await Providers().nivelAgregar(
                      nombreCtrl.text.trim(),
                    );

                    // if (respuesta['message'] != null) {
                    //   //nombre
                    //   if (respuesta['errors']['nombre'] != null) {
                    //     errNombre = respuesta['errors']['nombre'][0];
                    //   }
                    setState(() {});
                    //   return;
                    // }

                    Navigator.pop(context);
                  }, //Fuera de onPressed
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
