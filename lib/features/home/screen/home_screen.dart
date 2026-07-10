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
        showBackButton: false,
        profileImageUrl: widget.profile.photoUrl,
        onNotification: () {
          // TODO: buka halaman notifikasi
        },
        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
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
              Navigator.pushNamed(
                context,
                AppRouter.home,
              );
              break;

            case 1:
              // Event
              break;

            case 2:
              // Scanner
              Navigator.pushNamed(
                context,
                AppRouter.scanner,
              );
              break;

            case 3:
              // Blog
              Navigator.pushNamed(
                context,
                AppRouter.blog,
              );
              break;

            case 4:
              Navigator.pushNamed(
                context,
                AppRouter.profile,
              );
              break;
          }
        },
      ),
    );
  }
}
