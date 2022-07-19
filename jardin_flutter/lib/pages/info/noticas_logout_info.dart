import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/services/firestore_service.dart';

class NoticiasLogOutInfo extends StatefulWidget {
  String noticiaId;
  NoticiasLogOutInfo(this.noticiaId, {Key? key}) : super(key: key);

  @override
  State<NoticiasLogOutInfo> createState() => _NoticiasLogOutInfoState();
}

class _NoticiasLogOutInfoState extends State<NoticiasLogOutInfo> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nombreCtrl = TextEditingController();
    TextEditingController textoCtrl = TextEditingController();
    TextEditingController fechaCtrl = TextEditingController();
    TextEditingController horaCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 191, 191),
      appBar: AppBar(
        title: Text('Informacion Noticia'),
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
                    Text('General',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Divider(),
                    ListTile(
                      leading: Text(
                        'ID noticia: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      title: Text(widget.noticiaId),
                    ),
                    ListTile(
                        leading: Text(
                          'Titulo: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        title: Text(nombreCtrl.text)),
                    ListTile(
                        leading: Text(
                          'Texto: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        title: Text(textoCtrl.text)),
                    ListTile(
                        leading: Text(
                          'Fecha Publicada: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        title: Text(fechaCtrl.text)),
                    ListTile(
                        leading: Text(
                          'Hora Publicada: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        title: Text(horaCtrl.text)),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 242, 76, 5),
                        ),
                        child: Text('Editar Noticia'),
                        onPressed: () async {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => NoticiasEditar(noticia.id),
                          );
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        },
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
