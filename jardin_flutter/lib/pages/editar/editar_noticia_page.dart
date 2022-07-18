import 'package:flutter/material.dart';
import 'package:jardin_flutter/services/firestore_service.dart';

class NoticiasEditar extends StatefulWidget {
  String noticiaId;
  NoticiasEditar(this.noticiaId, {Key? key}) : super(key: key);

  @override
  State<NoticiasEditar> createState() => _NoticiasEditarState();
}

class _NoticiasEditarState extends State<NoticiasEditar> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nombreCtrl = TextEditingController();
    TextEditingController textoCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Noticia'),
        backgroundColor: Color(0xFF363942),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(5),
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

                return ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        children: [
                          Text(
                            'Id Producto:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.noticiaId),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre noticia',
                      ),
                    ),
                    TextFormField(
                      controller: textoCtrl,
                      decoration: InputDecoration(
                        labelText: 'Texto',
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        child: Text('Editar Producto'),
                        onPressed: () async {
                          String nombre = nombreCtrl.text.trim();
                          String texto = textoCtrl.text.trim();

                          FirestoreService()
                              .noticiasEditar(widget.noticiaId, nombre, texto);
                          Navigator.pop(context);
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
