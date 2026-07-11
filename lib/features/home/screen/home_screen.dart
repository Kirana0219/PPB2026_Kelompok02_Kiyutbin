import 'package:flutter/material.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_bottom.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_header.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';
import 'package:kiyutbin_mobile/core/routes/app_router.dart';

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
      backgroundColor: const Color(0xFFF7F9F8),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Greeting
            Text(
              "Hi, ${widget.profile.fullName} 👋",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Let's save the earth together.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            /// Banner
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF57A95A),
                    Color(0xFF86D48A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.recycling,
                    color: Colors.white,
                    size: 60,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Recycle Today",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Small Actions, Big Impact",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// About
            Row(
              children: const [

                Icon(
                  Icons.eco,
                  color: Colors.green,
                ),

                SizedBox(width: 8),

                Text(
                  "Tentang KIYUTBIN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                "KIYUTBIN merupakan platform edukasi digital mengenai pengelolaan sampah yang membantu masyarakat memahami cara memilah sampah dengan benar serta meningkatkan kepedulian terhadap lingkungan.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// Location
            Row(
              children: const [

                Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),

                SizedBox(width: 8),

                Text(
                  "Lokasi Bank Sampah",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Icon(
                    Icons.location_pin,
                    color: Colors.green,
                    size: 46,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Temukan Bank Sampah Terdekat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Cari lokasi bank sampah di sekitar Anda dan mulai berkontribusi menjaga lingkungan.",
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Google Maps
                      },
                      icon: const Icon(Icons.map),
                      label: const Text("Lihat Lokasi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF57A95A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
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
              Navigator.pushNamed(
                context,
                AppRouter.events,
              );
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
