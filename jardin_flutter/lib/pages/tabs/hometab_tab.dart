import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/jardin_card.dart';

class HomeTab extends StatelessWidget {
  final jardin = [
    {
      'imagen': 'imagen1.jpg',
    },
    {
      'imagen': 'imagen2.jpg',
    },
    {
      'imagen': 'imagen3.jpg',
    },
    {
      'imagen': 'imagen4.jpg',
    },
    {
      'imagen': 'imagen5.jpg',
    },
    {
      'imagen': 'imagen6.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        reverse: true,
        children: jardin.map((jardin) {
          return JardinCard(
            imagen: jardin['imagen'].toString(),
          );
        }).toList(),
      ),
    );
  }
}
