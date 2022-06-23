import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/agregar_estudiante_page.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EstudiantesTab extends StatefulWidget {
  @override
  State<EstudiantesTab> createState() => _EstudiantesTabState();
}

class _EstudiantesTabState extends State<EstudiantesTab> {
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
                      return Dismissible(
                        key: ObjectKey(alumn),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Borrar',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                MdiIcons.closeThick,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(
                            MdiIcons.foodApple,
                            color: Color.fromARGB(255, 143, 195, 80),
                          ),
                          title:
                              Text('${alumn['nombre']} ${alumn['apellido']}'),
                          subtitle: Text('Id: ${alumn['id']}'),
                          trailing: Text('Edad: ${alumn['edad']} años'),
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
}
