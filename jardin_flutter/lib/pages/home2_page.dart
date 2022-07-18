import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/pages/login_page.dart';
import 'package:jardin_flutter/providers/google_sign_in.dart';
import 'package:jardin_flutter/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
        title: Row(
          children: [
            //Cambiar Icon por un Drawer
            Icon(
              MdiIcons.seed,
              color: Color.fromARGB(255, 143, 195, 80),
            ),
            Spacer(),
            Text('Jardin Semillita'),
            Spacer(),
            PopupMenuButton(
              icon: Icon(MdiIcons.email),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'google',
                  child: Center(
                    child: Text(
                      'Iniciar Sesion con Google',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              onSelected: (opcion) {
                if (opcion == 'google') {
                  final provider =
                      Provider.of<GoogleSingInProvider>(context, listen: false);
                  provider.googleLogin();
                }
              },
            ),
          ],
        ),
      ),
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

                      return ListTile(
                        leading: Icon(MdiIcons.cube),
                        title: Text('${noticia['nombre']}'),
                        subtitle: Text('Fecha: ${noticia['fecha']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
