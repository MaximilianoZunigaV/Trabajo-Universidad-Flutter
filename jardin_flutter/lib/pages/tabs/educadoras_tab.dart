import 'package:flutter/material.dart';

class EducadorasTab extends StatelessWidget {
  const EducadorasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Educadoras',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
