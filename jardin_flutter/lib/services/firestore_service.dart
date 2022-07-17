import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  //obtener todos los productos
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance.collection('noticias').snapshots();
    //int limite = 5;
    //return FirebaseFirestore.instance.collection('productos').where('stock', isLessThan: limite).snapshots();
  }

  //agregar productos
  Future noticiasAgregar(
      String nombre, String texto, String fecha, String hora) {
    return FirebaseFirestore.instance.collection('noticias').doc().set({
      'nombre': nombre,
      'texto': texto,
      'fecha': fecha,
      'hora': hora,
    });
  }

  //borrar noticia
  Future noticiasBorrar(String noticiaId) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticia(
      String noticiaId) async {
    return await FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .get();
    // print(prod['nombre']);
  }

  Future noticiasEditar(String noticiaId, String nombre, String texto,
      String fecha, String hora) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .update({
      'nombre': nombre,
      'texto': texto,
      'fecha': fecha,
      'hora': hora,
    });
  }
}
