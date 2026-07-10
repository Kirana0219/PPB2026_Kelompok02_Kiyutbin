import 'package:flutter/material.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_bottom.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_header.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';
import 'package:kiyutbin_mobile/core/routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.profile,
  });

  final AuthModel profile;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        showBackButton: false, // Home tidak perlu tombol back
        profileImage: 'assets/images/profile.png', // opsional
        onNotification: () {
          // TODO: buka halaman notifikasi
        },
        onProfile: () {
          // TODO: buka halaman profile
        },
      ),

      body: Center(
        child: Text(
          'Halo ${widget.profile.fullName}',
        ),
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          switch (index) {
            case 0:
              break;

            case 1:
              // Event
              break;

            case 2:
              Navigator.pushNamed(
                context,
                AppRouter.scanner,
              );
              break;

            case 3:
              Navigator.pushNamed(
                context,
                AppRouter.blog,
              );
              break;

            case 4:
              // Profile
              break;
          }
        },
      ),
    );
  }
}