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
      appBar: AppBar(
        title: Text(' Jardin Semillita'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(0),
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

                return Container(
                  child: Stack(
                    children: [
                      Material(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 190, 92),
                                Color.fromARGB(255, 131, 219, 134),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(children: [
                            Text(''),
                            Positioned(
                              top: 200,
                              child: ListTile(
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
                                ),
                              ),
                            ),
                            Text(''),
                            Positioned(
                              top: 200,
                              child: ListTile(
                                title: Text(
                                  textoCtrl.text,
                                  style: TextStyle(fontSize: 18, shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      offset: Offset(1, 2),
                                      blurRadius: 8,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Spacer(),
                            Positioned(
                              top: 10,
                              left: 355,
                              child: Text(
                                fechaCtrl.text,
                                style: TextStyle(fontSize: 16, shadows: [
                                  Shadow(
                                    color: Color.fromARGB(255, 245, 245, 245),
                                    offset: Offset(2, 1),
                                    blurRadius: 6,
                                  ),
                                ]),
                              ),
                            ),
                            Text(''),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
