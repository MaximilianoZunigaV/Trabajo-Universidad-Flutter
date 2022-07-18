import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  //obtener noticias
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance.collection('noticias').snapshots();
  }

  //agregar noticia
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
  }

  Future noticiasEditar(String noticiaId, String nombre, String texto) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .update({
      'nombre': nombre,
      'texto': texto,
    });
  }
}
