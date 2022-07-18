import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jardin_flutter/pages/login_page.dart';
import 'package:jardin_flutter/pages/tabs/educadoras_tab.dart';
import 'package:jardin_flutter/pages/tabs/estudiantes_tab.dart';
import 'package:jardin_flutter/pages/tabs/eventos_tab.dart';
import 'package:jardin_flutter/pages/tabs/hometab_tab.dart';
import 'package:jardin_flutter/pages/tabs/niveles_tab.dart';
import 'package:jardin_flutter/pages/tabs/noticias_tab.dart';
import 'package:jardin_flutter/providers/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int index = 0;
  String image =
      'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg';

  List<String> miImages = [
    'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg',
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
          title: Row(
            children: [
              //Cambiar Icon por un Drawer
              Icon(
                MdiIcons.home,
                color: Color.fromARGB(255, 143, 195, 80),
              ),
              Spacer(),
              Text('Jardin Semillita'),
              Spacer(),
              PopupMenuButton(
                icon: Icon(MdiIcons.emailCheck),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Center(
                      child: Text(
                        'Cerrar Sesion',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                onSelected: (opcion) {
                  if (opcion == 'logout') {
                    final provider = Provider.of<GoogleSingInProvider>(context,
                        listen: false);
                    provider.googleLogout();
                  }
                },
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 242, 76, 5),
          expandedHeight: 800.0,
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
                  text: 'Noticias',
                  icon: Icon(MdiIcons.newspaper),
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
              NoticiasTab(),
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
