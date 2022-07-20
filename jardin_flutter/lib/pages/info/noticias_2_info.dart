import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/services/firestore_service.dart';

class Noticias2Info extends StatefulWidget {
  String noticiaId;
  Noticias2Info(this.noticiaId, {Key? key}) : super(key: key);

  @override
  State<Noticias2Info> createState() => _Noticias2InfoState();
}

class _Noticias2InfoState extends State<Noticias2Info> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nombreCtrl = TextEditingController();
    TextEditingController textoCtrl = TextEditingController();
    TextEditingController fechaCtrl = TextEditingController();
    TextEditingController horaCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 232, 182),
      appBar: AppBar(
        title: Text('Información Noticia'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
              future: FirestoreService().getNoticia(widget.noticiaId),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var noticia = snapshot.data;
                nombreCtrl.text = noticia['nombre'];
                textoCtrl.text = noticia['texto'];
                fechaCtrl.text = noticia['fecha'];
                horaCtrl.text = noticia['hora'];

                return ListView(
                  padding: EdgeInsets.all(20.0),
                  children: [
                    Text(
                      'Noticia publicada el dia ' +
                          fechaCtrl.text +
                          ' a las ' +
                          horaCtrl.text +
                          'hrs',
                      style: TextStyle(fontSize: 14, shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: Offset(2, 1),
                          blurRadius: 6,
                        )
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      height: 20,
                    ),
                    ListTile(
                      title: Text(
                        nombreCtrl.text,
                        style: TextStyle(fontSize: 24, shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 220, 226, 213),
                            offset: Offset(1, 2),
                            blurRadius: 4,
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset(2, 1),
                            blurRadius: 6,
                          ),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 20,
                    ),
                    ListTile(
                      title: Text(
                        textoCtrl.text,
                        style: TextStyle(fontSize: 18, shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset(1, 2),
                            blurRadius: 8,
                          ),
                        ]),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
