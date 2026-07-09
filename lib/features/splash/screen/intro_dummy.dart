import 'package:flutter/material.dart';

class IntroDummy extends StatelessWidget {
  const IntroDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen Berhasil!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}