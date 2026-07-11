import 'dart:async';

import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  Timer? _timer;

  final List<_BannerItem> banners = [
    _BannerItem(
      image: "assets/images/banner1.jpeg",
      title: "Reduce Waste",
      subtitle:
          "Start sorting your waste today and create a cleaner environment.",
    ),
    _BannerItem(
      image: "assets/images/banner2.jpeg",
      title: "Recycle Today",
      subtitle: "Small recycling actions make a big impact for our planet.",
    ),
    _BannerItem(
      image: "assets/images/banner3.jpeg",
      title: "Save The Earth",
      subtitle: "Together we can build a greener future for everyone.",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      _currentPage++;

      if (_currentPage >= banners.length) {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 185,

          child: PageView.builder(
            controller: _pageController,

            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },

            itemCount: banners.length,

            itemBuilder: (context, index) {
              final banner = banners[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),

                  child: Stack(
                    fit: StackFit.expand,

                    children: [
                      /// Background Image
                      Image.asset(banner.image, fit: BoxFit.cover),

                      /// Dark Overlay
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(0, 0, 0, .72),
                              Color.fromRGBO(0, 0, 0, .38),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      /// Text
                      Padding(
                        padding: const EdgeInsets.all(22),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              banner.title,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 10),

                            SizedBox(
                              width: 180,

                              child: Text(
                                banner.subtitle,

                                style: const TextStyle(
                                  color: Colors.white,
                                  height: 1.45,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: List.generate(
            banners.length,

            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),

              margin: const EdgeInsets.symmetric(horizontal: 4),

              height: 8,

              width: _currentPage == index ? 22 : 8,

              decoration: BoxDecoration(
                color: _currentPage == index
                    ? const Color(0xff0D631B)
                    : Colors.grey.shade300,

                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerItem {
  final String image;
  final String title;
  final String subtitle;

  const _BannerItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
