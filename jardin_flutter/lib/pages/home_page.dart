import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/tabs/educadoras_tab.dart';
import 'package:jardin_flutter/pages/tabs/estudiantes_tab.dart';
import 'package:jardin_flutter/pages/tabs/eventos_tab.dart';
import 'package:jardin_flutter/pages/tabs/hometab_tab.dart';
import 'package:jardin_flutter/pages/tabs/niveles_tab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int index = 0;
  String image = 'https://i.postimg.cc/GhWByfgt/card.jpg';

  List<String> miImages = [
    'https://i.postimg.cc/GhWByfgt/card.jpg',
    'https://stjosephsinfants.ie/wp-content/uploads/2021/01/little-school-children-learning_29937-3161.jpg',
    'https://static.vecteezy.com/system/resources/previews/003/171/581/non_2x/cartoon-female-teacher-holding-book-and-point-to-blackboard-with-rule-vector.jpg',
    'https://i.pinimg.com/736x/94/43/b8/9443b8fc18a439388a9ecb715878453c.jpg',
    'https://centroactiva.com/wp-content/uploads/2022/02/nin%CC%83os-jugando-en-sala-actividad-infantil-jardines-de-infancia-dibujos-animados-y-nin%CC%83as-preescolar-juegan-juguetes-dibujan-vector-209950932.jpeg'
  ];

  void _tabListener() {
    setState(() {
      index = tabController!.index;
      image = miImages[index];
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController!.addListener((_tabListener));
    super.initState();
  }

  @override
  void dispose() {
    tabController!.removeListener(_tabListener);
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0.0,
          pinned: true,
          title: Text(
            'Jardin Semillitas',
            style: TextStyle(color: Colors.transparent),
          ),
          backgroundColor: Color.fromARGB(255, 242, 76, 5),
          expandedHeight: 400.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Image.network(image, fit: BoxFit.cover),
          ),
        ),
        SliverAppBar(
          pinned: true,
          primary: false,
          elevation: 8.0,
          backgroundColor: Color.fromARGB(255, 242, 76, 5),
          title: Align(
            alignment: AlignmentDirectional.center,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.red,
              tabs: [
                Tab(
                  text: 'Home',
                  icon: Icon(MdiIcons.home),
                ),
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
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: 700.0,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: TabBarView(controller: tabController, children: [
              HomeTab(),
              EstudiantesTab(),
              EducadorasTab(),
              EventosTab(),
              NivelesTab(),
            ]),
          ),
        ))
      ],
    );
  }
}
