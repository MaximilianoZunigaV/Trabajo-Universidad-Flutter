import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/tabs/educadoras_tab.dart';
import 'package:jardin_flutter/pages/tabs/estudiantes_tab.dart';
import 'package:jardin_flutter/pages/tabs/eventos_tab.dart';
import 'package:jardin_flutter/pages/tabs/niveles_tab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
            title: Text('Jardin Semillita'),
            backgroundColor: Color.fromARGB(255, 242, 76, 5),
            leading: Icon(MdiIcons.seed),
          ),
          body: TabBarView(
            children: [
              EstudianteTab(),
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
