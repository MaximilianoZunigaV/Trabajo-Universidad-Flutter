import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jardin_flutter/pages/agregar/agregar_evento_page.dart';
import 'package:jardin_flutter/pages/editar/editar_evento_page.dart';
import 'package:jardin_flutter/pages/info/evento_info.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventosTab extends StatefulWidget {
  @override
  State<EventosTab> createState() => _EventosTabState();
}

class _EventosTabState extends State<EventosTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 243, 243),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Providers().getEventos(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var event = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 126, 214, 214),
                          leading: Icon(
                            MdiIcons.bookOpenVariant,
                          ),
                          title: Text('Causa: ${event['nombre']}'),
                          subtitle: Text(
                              'Codigo Estudiante: ${event['estudiantes_id']}'),
                          // onLongPress: () {
                          trailing:
                              Text('${event['fecha']} \n ${event['hora']}'),
                          //   MaterialPageRoute route = MaterialPageRoute(
                          //     builder: (context) =>
                          //         EventoEditarPage(event['id']),
                          //   );
                          //   Navigator.push(context, route).then((value) {
                          //     setState(() {});
                          //   });
                          // },
                          // onTap: () {
                          //   MaterialPageRoute route = MaterialPageRoute(
                          //     builder: (context) => EventoInfoPage(event['id']),
                          //   );
                          //   Navigator.push(context, route).then((value) {
                          //     setState(() {});
                          //   });
                          // },
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String eventId = event['id'].toString();
                                String nombre = event['nombre'];

                                confirmDialog(context, nombre).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    Providers()
                                        .eventoBorrar(eventId)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Evento $nombre borrado');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar el evento');
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

            //agregar
            Container(
              //width: double.infinity,
              child: FloatingActionButton(
                isExtended: false,
                child: Icon(MdiIcons.plusThick),
                elevation: 100.0,
                backgroundColor: Color.fromARGB(255, 242, 76, 5),
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return AgregarEvento();
                  });

                  Navigator.push(context, route).then((value) {
                    setState(() {});
                  });
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

  Future<dynamic> confirmDialog(BuildContext context, String evento) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el evento $evento?'),
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
