import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'intro_dummy.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const IntroDummy(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
            child: Stack(
                children: [
                Center(
                    child: Image.asset(
                    'assets/images/BRAND_ICON_WHITE.png',
                    width: 150,
                    ),
                ),

                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        const Text(
                        'From',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                        ),
                        ),

                        const SizedBox(height: 12),

                        Image.asset(
                        'assets/images/BRAND_NAME_WHITE.png',
                        width: 170,
                        ),
                    ],
                    ),
                ),
                ],
            ),
        ),
    );
  }
}