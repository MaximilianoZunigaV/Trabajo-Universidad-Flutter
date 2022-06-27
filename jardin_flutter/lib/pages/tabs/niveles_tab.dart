import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/agregar/agregar_nivel_page.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NivelesTab extends StatefulWidget {
  @override
  State<NivelesTab> createState() => _NivelesTabState();
}

class _NivelesTabState extends State<NivelesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Providers().getNiveles(),
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
                      var level = snap.data[index];
                      return Dismissible(
                        key: ObjectKey(level),
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
                            MdiIcons.fruitPineapple,
                            color: Color.fromARGB(255, 143, 195, 80),
                          ),
                          title: Text(level['nombre']),
                          subtitle: Text('ID del Nivel: ${level['id']}'),
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
                child: Icon(MdiIcons.plusThick),
                elevation: 50.0,
                backgroundColor: Color.fromARGB(255, 242, 76, 5),
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return AgregarNivel();
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
