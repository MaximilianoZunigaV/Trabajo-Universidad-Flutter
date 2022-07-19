import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/pages/home_page.dart';
import 'package:jardin_flutter/pages/info/noticas_logout_info.dart';

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
  String error = "";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 246, 215),
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
            // PopupMenuButton(
            //   icon: Icon(MdiIcons.email),
            //   itemBuilder: (context) => [
            //     PopupMenuItem(
            //       value: 'google',
            //       child: Center(
            //         child: Text(
            //           'Iniciar Sesion con Google',
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //   ],
            //   onSelected: (opcion) {
            //     if (opcion == 'google') {
            //       final provider =
            //           Provider.of<GoogleSingInProvider>(context, listen: false);
            //       provider.googleLogin();
            //     }
            //   },
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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

                      return Container(
                        // height: 130.0,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Material(
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 190, 92),
                                        Color.fromARGB(255, 131, 219, 134),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    /*boxShadow: [
                                        new BoxShadow(
                                            color: Color(0xFF363f93)
                                                .withOpacity(0.3),
                                            offset: new Offset(-10.0, 0.0),
                                            blurRadius: 20.0,
                                            spreadRadius: 4.0)
                                      ]*/
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 20,
                              child: Card(
                                elevation: 10.0,
                                shadowColor: Color.fromARGB(255, 158, 158, 158)
                                    .withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 120,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(255, 245, 226, 160),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/images/noticias.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 37,
                              child: Text(
                                noticia['fecha'],
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 355,
                              child: Column(
                                children: [
                                  Container(
                                    width: 0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: ElevatedButton(
                                      child: Icon(MdiIcons.arrowTopRight),
                                      onPressed: () {
                                        MaterialPageRoute route =
                                            MaterialPageRoute(
                                          builder: (context) =>
                                              NoticiasLogOutInfo(noticia.id),
                                        );
                                        Navigator.push(context, route)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 34, 99, 36)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 140,
                              child: Container(
                                  height: 390,
                                  width: 250,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        //leading: Text('${noticia['fecha']}'),
                                        title: Text(
                                          '${noticia['nombre']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        //Text('Fecha: ${noticia['fecha']}'),
                                        textColor: Colors.white,

                                        // subtitle: Text(
                                        //     //tileColor: Color.fromARGB(255, 209, 122, 47),
                                        //     ' \n ${noticia['texto']}'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        onTap: () {
                                          MaterialPageRoute route =
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                NoticiasLogOutInfo(noticia.id),
                                          );
                                          Navigator.push(context, route)
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                      )
                                    ],
                                  )),
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
              padding: EdgeInsets.all(15),
              //color: Colors.orange.shade200,
              height: 90,
              child: ListView(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 42)),
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.orange,
                    ),
                    label: Text('Iniciar Sesion con Google'),
                    onPressed: () async {
                      final provider = Provider.of<GoogleSingInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
