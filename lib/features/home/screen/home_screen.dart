import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';

import '../../auth/models/auth_model.dart';

import '../widgets/home_banner.dart';
import '../widgets/quick_menu.dart';
import '../widgets/home_event_section.dart';
import '../widgets/home_blog_section.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        showBackButton: false,
        profileImageUrl: widget.profile.photoUrl,
        onNotification: () {
          Navigator.pushNamed(context, AppRouter.notification);
        },

        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// Greeting
              Text(
                "Hi, ${widget.profile.fullName} 👋",

                style: const TextStyle(
                  fontSize: 28,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Save The Earth Together",

                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              /// Banner
              const HomeBanner(),

              const SizedBox(height: 28),

              /// Quick Menu
              const QuickMenu(),

              const SizedBox(height: 32),

              /// Event
              const HomeEventSection(),

              const SizedBox(height: 32),

              /// Blog
              const HomeBlogSection(),

              const SizedBox(height: 20),
            ],
          ),
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
              Navigator.pushNamed(context, AppRouter.home);

              break;

            case 1:
              Navigator.pushNamed(context, AppRouter.events);

              break;

            case 2:
              Navigator.pushNamed(context, AppRouter.scanner);

              break;

            case 3:
              Navigator.pushNamed(context, AppRouter.blog);

              break;

            case 4:
              Navigator.pushNamed(context, AppRouter.profile);

              break;
          }
        },
      ),
    );
  }
}
