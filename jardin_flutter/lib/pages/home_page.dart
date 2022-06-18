import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/tabs/educadoras_tab.dart';
import 'package:jardin_flutter/pages/tabs/estudiantes_tab.dart';
import 'package:jardin_flutter/pages/tabs/eventos_tab.dart';
import 'package:jardin_flutter/pages/tabs/niveles_tab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: TabBar(
              //isScrollable: false,
              tabs: [
                Tab(
                  text: 'Niños',
                  icon: Icon(MdiIcons.humanChild),
                ),
                Tab(
                  text: 'Educadoras',
                  icon: Icon(MdiIcons.faceWoman),
                ),
                Tab(
                  text: 'Eventos',
                  icon: Icon(MdiIcons.bookOpenVariant),
                ),
                Tab(
                  text: 'Niveles',
                  icon: Icon(MdiIcons.school),
                ),
              ],
            ),
            title: Text(
              'Jardin Semillita',
              style: TextStyle(
                color: Color.fromARGB(255, 143, 195, 80),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 242, 76, 5),
            leading: Icon(
              MdiIcons.seed,
              color: Color.fromARGB(255, 143, 195, 80),
            ),
          ),
          body: TabBarView(
            children: [
              EstudiantesTab(),
              EducadorasTab(),
              EventosTab(),
              NivelesTab(),
            ],
          ),
        ),
      ),
    );
  }
}
