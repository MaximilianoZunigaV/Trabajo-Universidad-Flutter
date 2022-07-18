import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jardin_flutter/pages/editar/editar_estudiante_page.dart';
import 'package:jardin_flutter/pages/info/estudiantes_info.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../agregar/agregar_estudiante_page.dart';

class EstudiantesTab extends StatefulWidget {
  @override
  State<EstudiantesTab> createState() => _EstudiantesTabState();
}

class _EstudiantesTabState extends State<EstudiantesTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Providers().getEstudiantes(),
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
                      var alumn = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          tileColor:
                              Colors.primaries[index % Colors.primaries.length],
                          leading: Icon(
                            MdiIcons.foodApple,
                            color: Colors.white,
                          ),
                          title: Text(
                            '${alumn['nombre']} ${alumn['apellido']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text('Edad: ${alumn['edad']} años'),
                          onLongPress: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) =>
                                  EstudianteEditarPage(alumn['id']),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                          onTap: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) =>
                                  EstudianteInfoPage(alumn['id']),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String alumnid = alumn['id'].toString();
                                String nombre = alumn['nombre'];

                                confirmDialog(context, nombre).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    Providers()
                                        .estudianteBorrar(alumnid)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar(
                                            'Estudiante $nombre borrado');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar el estudiante');
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
                    return AgregarEstudiante();
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

  Future<dynamic> confirmDialog(BuildContext context, String alumno) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el estudiante $alumno?'),
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
