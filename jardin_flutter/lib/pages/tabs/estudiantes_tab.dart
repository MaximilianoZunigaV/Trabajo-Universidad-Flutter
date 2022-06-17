import 'package:flutter/material.dart';
import 'package:jardin_flutter/providers/providers_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EstudiantesTab extends StatelessWidget {
  const EstudiantesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Expanded(
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
                  return ListTile(
                    leading: Icon(MdiIcons.cube),
                    title: Text(alumn['nombre']),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
