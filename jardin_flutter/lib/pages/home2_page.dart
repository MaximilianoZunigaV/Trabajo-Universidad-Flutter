import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jardin_flutter/pages/editar/editar_noticia_page.dart';
import 'package:jardin_flutter/pages/home_page.dart';
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
      backgroundColor: Colors.orange.shade300,
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
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 208, 147, 56),
                                Color.fromARGB(255, 94, 173, 97),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            /*boxShadow: [
                                BoxShadow(
                                    blurRadius: 8.0, offset: Offset(0, 5)),
                              ]*/
                          ),
                          child: ListTile(
                            //leading: Icon(MdiIcons.cube),
                            title: Text('${noticia['nombre']}'),
                            subtitle: Text('Fecha: ${noticia['fecha']}'),
                            textColor: Colors.white,
                            //tileColor: Color.fromARGB(255, 209, 122, 47),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              //color: Colors.orange.shade200,
              height: 130,
              child: ListView(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 42)),
                    icon: Icon(MdiIcons.email),
                    label: Text('Iniciar Sesion'),
                    onPressed: () {
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      });

                      Navigator.push(context, route).then((value) {
                        setState(() {});
                      });
                    },
                  ),
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
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
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
