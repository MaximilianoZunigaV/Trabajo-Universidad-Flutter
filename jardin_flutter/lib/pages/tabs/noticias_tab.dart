import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jardin_flutter/pages/agregar/agregar_noticias_page.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/pages/info/estudiantes_info.dart';
import 'package:jardin_flutter/pages/info/noticias_info.dart';
import 'package:jardin_flutter/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticiasTab extends StatefulWidget {
  const NoticiasTab({Key? key}) : super(key: key);

  @override
  State<NoticiasTab> createState() => _NoticiasTabState();
}

class _NoticiasTabState extends State<NoticiasTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 191, 191),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirestoreService().noticias(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var noticia = snapshot.data!.docs[index];

                      return Slidable(
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 219, 150, 150),
                          leading: Icon(MdiIcons.newspaper),
                          title: Text('${noticia['nombre']}'),
                          subtitle: Text('Fecha: ${noticia['fecha']}'),
                          onLongPress: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => NoticiasEditar(noticia.id),
                            );
                            Navigator.push(context, route);
                          },
                          onTap: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => NoticiasInfo(noticia.id),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String nombre = noticia['nombre'];

                                confirmDialog(context, nombre).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    FirestoreService()
                                        .noticiasBorrar(noticia.id)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snapshot..data!.docs.removeAt(index);
                                        setState(() {});
                                        showSnackbar(
                                            'Educadora $nombre borrada');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar la noticia');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: MdiIcons.trashCan,
                              label: 'Borrar',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              height: 65,
              //width: double.infinity,
              child: FloatingActionButton(
                //isExtended: false,
                child: Icon(MdiIcons.plusThick),
                elevation: 100.0,
                backgroundColor: Color.fromARGB(255, 242, 76, 5),
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => NoticiasAgregar(),
                  );

                  Navigator.push(context, route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String nombre) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar la noticia $nombre?'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
