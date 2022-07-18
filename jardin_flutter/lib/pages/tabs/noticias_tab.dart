import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/agregar/agregar_noticias_page.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticiasTab extends StatelessWidget {
  const NoticiasTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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

                    return ListTile(
                      leading: Icon(MdiIcons.cube),
                      title: Text('${noticia['nombre']}'),
                      subtitle: Text('Fecha: ${noticia['fecha']}'),
                      trailing: TextButton(
                        child: Icon(
                          MdiIcons.trashCan,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // print(producto.id);
                          FirestoreService().noticiasBorrar(noticia.id);
                        },
                      ),
                      onLongPress: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => NoticiasEditar(noticia.id),
                        );
                        Navigator.push(context, route);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => NoticiasAgregar(),
          );
          Navigator.push(context, route);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
