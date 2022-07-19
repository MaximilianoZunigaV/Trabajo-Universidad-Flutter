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
    'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg',
    'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg',
    'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg',
    'https://cdn.discordapp.com/attachments/984198190729424996/998399517168779274/card.jpg',
    // 'https://stjosephsinfants.ie/wp-content/uploads/2021/01/little-school-children-learning_29937-3161.jpg',
    // 'https://static.vecteezy.com/system/resources/previews/003/171/581/non_2x/cartoon-female-teacher-holding-book-and-point-to-blackboard-with-rule-vector.jpg',
    // 'https://i.pinimg.com/736x/94/43/b8/9443b8fc18a439388a9ecb715878453c.jpg',
    // 'https://centroactiva.com/wp-content/uploads/2022/02/nin%CC%83os-jugando-en-sala-actividad-infantil-jardines-de-infancia-dibujos-animados-y-nin%CC%83as-preescolar-juegan-juguetes-dibujan-vector-209950932.jpeg'
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
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            pinned: true,
            title: Row(
              children: [
                //Cambiar Icon por un Drawer
                Spacer(),
                Text(
                  'Jardin Semillita',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                      fontSize: 26,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 143, 195, 80),
                          offset: Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ]),
                ),
                Text('      '),
                Spacer(),
                Icon(MdiIcons.emailCheck),
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
            automaticallyImplyLeading:
                false, //para que no se duplique el drawer en este SliverAppBar
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
                    text: 'Niños',
                    icon: Icon(MdiIcons.humanChild),
                  ),
                  Tab(
                    text: 'Educadoras',
                    icon: Icon(MdiIcons.faceWoman),
                  ),
                  Tab(
                    text: 'Niveles',
                    icon: Icon(MdiIcons.school),
                  ),
                  Tab(
                    text: 'Eventos',
                    icon: Icon(MdiIcons.bookOpenVariant),
                  ),
                  Tab(
                    text: 'Noticias',
                    icon: Icon(MdiIcons.newspaper),
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
                EstudiantesTab(),
                EducadorasTab(),
                NivelesTab(),
                EventosTab(),
                NoticiasTab(),
              ]),
            ),
          ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 233, 133, 91),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
            ),
            Text(
              'Perfil',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 143, 195, 80),
                      offset: Offset(1, 2),
                      blurRadius: 4,
                    ),
                  ]),
            ),
            Container(
              height: 10,
            ),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 143, 195, 80),
              radius: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 95,
              ),
            ),
            Container(
              height: 20,
            ),
            Text(
              user.displayName!,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              user.email!,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: Text(
                  'Cerrar Sesion',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSingInProvider>(context, listen: false);
                  provider.googleLogout();
                  Navigator.pop(context);
                }, //Fuera de onPressed
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 143, 195, 80),
                ), //Cambiar color del boton
              ),
            ),
          ],
        ),
      ),
    );
  }
}
