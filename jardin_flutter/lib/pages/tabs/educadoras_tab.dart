import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jardin_flutter/pages/agregar/agregar_educadora_page.dart';
import 'package:jardin_flutter/pages/editar/editar_educadora_page.dart';
import 'package:jardin_flutter/pages/editar/editar_estudiante_page.dart';
import 'package:jardin_flutter/pages/info/educadora_info.dart';
import 'package:jardin_flutter/pages/info/estudiantes_info.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../agregar/agregar_estudiante_page.dart';

class EducadorasTab extends StatefulWidget {
  @override
  State<EducadorasTab> createState() => _EducadorasTabState();
}

class _EducadorasTabState extends State<EducadorasTab> {
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
                future: Providers().getEducadoras(),
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
                      var edu = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(
                            MdiIcons.foodApple,
                            color: Color.fromARGB(255, 143, 195, 80),
                          ),
                          title: Text('${edu['nombre']} ${edu['apellido']}'),
                          subtitle: Text(edu['email']),
                          onLongPress: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) =>
                                  EducadoraEditarPage(edu['id']),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                          onTap: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) =>
                                  EducadoraInfoPage(edu['id']),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String codEdu = edu['id'].toString();
                                String nombre = edu['nombre'];

                                confirmDialog(context, nombre).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    Providers()
                                        .educadoraBorrar(codEdu)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar(
                                            'Educadora $nombre borrada');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar la educadora');
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
                    return AgregarEducadora();
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

  Future<dynamic> confirmDialog(BuildContext context, String educadora) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar la educadora $educadora?'),
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
