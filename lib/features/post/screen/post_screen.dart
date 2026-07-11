import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';

import '../model/post_model.dart';
import '../services/post_service.dart';
import '../widgets/post_card.dart';
import '../widgets/post_carousel.dart';
import '../widgets/post_section_header.dart';
import 'post_detail_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

  String keyword = "";

  List<PostModel> get products => PostService.posts;

  List<PostModel> get featuredProducts => products.take(3).toList();

  List<PostModel> get latestProducts {
    if (keyword.isEmpty) return products;

    return products.where((e) {
      return e.title.toLowerCase().contains(keyword.toLowerCase()) ||
          e.category.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }

  void openDetail(PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetailScreen(post: post)),
    );
  }

  void onBottomTap(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.home,
          (_) => false,
        );
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
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppHeader(
        showBackButton: true,

        onNotification: () {
          Navigator.pushNamed(context, AppRouter.notification);
        },

        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
        },
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),

        children: [
          /// SEARCH
          Container(
            height: 50,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(30),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 10,
                ),
              ],
            ),

            child: TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },

              decoration: const InputDecoration(
                border: InputBorder.none,

                hintText: "Search product...",

                prefixIcon: Icon(Icons.search),

                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          const SizedBox(height: 28),

          /// FEATURED
          PostSectionHeader(title: "Featured Products", onViewAll: () {}),

          const SizedBox(height: 16),

          PostCarousel(posts: featuredProducts, onTap: openDetail),

          const SizedBox(height: 32),

          /// LATEST
          const PostSectionHeader(title: "Latest Products"),

          const SizedBox(height: 16),

          ...latestProducts.map(
            (post) => Padding(
              padding: const EdgeInsets.only(bottom: 18),

              child: PostCard(post: post, onTap: () => openDetail(post)),
            ),
          ),
        ],
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,

        onTap: onBottomTap,
      ),
    );
  }
}
