import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';

class NivelEditarPage extends StatefulWidget {
  int idNivel;
  NivelEditarPage(this.idNivel, {Key? key}) : super(key: key);

  @override
  State<NivelEditarPage> createState() => _NivelEditarPageState();
}

class _NivelEditarPageState extends State<NivelEditarPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  String errNombre = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
        title: Text(
          'Editar Nivel',
          style: TextStyle(color: Color.fromARGB(255, 143, 195, 80)),
        ),
      ),
      body: FutureBuilder(
        future: Providers().getNivel(widget.idNivel),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          //idCtrl.text = data['id'].toString();
          nombreCtrl.text = data['nombre'].toString();

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Este campo no puede quedar vacio';
                      }
                      return null;
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        Providers().nivelEditar(
                            widget.idNivel,
                            int.tryParse(idCtrl.text.trim()) ?? 0,
                            nombreCtrl.text.trim());

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
