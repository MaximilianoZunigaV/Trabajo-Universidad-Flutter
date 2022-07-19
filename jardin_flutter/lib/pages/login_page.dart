import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/home_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String error = "";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesion'),
        backgroundColor: Color.fromARGB(255, 242, 76, 5),
        leading: Icon(
          MdiIcons.seed,
          color: Color.fromARGB(255, 143, 195, 80),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Iniciar Sesión'),
                onPressed: () async {
                  UserCredential? userCredential;
                  try {
                    userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim(),
                    );

                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('userEmail', emailCtrl.text.trim());

                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => HomePage(),
                    );
                    Navigator.pushReplacement(context, route);
                  } on FirebaseAuthException catch (ex) {
                    // print('EXCEPTION: ${ex.code}');
                    switch (ex.code) {
                      case 'user-not-found':
                        error = 'Usuario no existe';
                        break;
                      case 'wrong-password':
                        error = 'Contraseña no válida';
                        break;
                      case 'user-disabled':
                        error = 'Cuenta desactivada';
                        break;
                      default:
                        error = 'Error desconocido';
                    }
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 143, 195, 80)),
              ),
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
    );
  }
}
