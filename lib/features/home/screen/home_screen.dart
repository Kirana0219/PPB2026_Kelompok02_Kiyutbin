import 'package:flutter/material.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_bottom.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_header.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';
import 'package:kiyutbin_mobile/core/routes/app_router.dart';
import 'package:kiyutbin_mobile/features/events/screens/events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.profile});

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
        profileImage: 'assets/images/profile.png',
        onNotification: () {
          // TODO: buka halaman notifikasi
        },
        onProfile: () {
          // TODO: buka halaman profile
        },
      ),

      body: Center(child: Text('Halo ${widget.profile.fullName}')),

      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EventScreen(profile: widget.profile),
              ),
            );
            return;
          }

          setState(() {
            currentIndex = index;
          });

          // TODO: navigasi footer
        },
      ),
    );
  }
}
