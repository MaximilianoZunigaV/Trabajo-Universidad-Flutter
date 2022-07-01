import 'package:flutter/material.dart';

class JardinCard extends StatelessWidget {
  final String imagen;
  const JardinCard({
    this.imagen = 'imagen1.jpg',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/${this.imagen}'),
            colorBlendMode: BlendMode.softLight,
          ),
        ],
      ),
    );
  }
}
