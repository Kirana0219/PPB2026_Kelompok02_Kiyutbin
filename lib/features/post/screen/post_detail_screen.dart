import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../model/post_model.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            SizedBox(
              height: 270,
              width: double.infinity,
              child: Image.asset(
                post.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primary.withValues(alpha: .12),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppColors.primary,
                    size: 64,
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      post.category,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Title
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Price
                  Text(
                    "Rp ${post.price}",
                    style: const TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const CircleAvatar(radius: 24, child: Icon(Icons.person)),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.seller,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "Seller",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.location_on, color: AppColors.primary),

                      const SizedBox(width: 4),

                      Text(post.location),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    post.description,
                    style: const TextStyle(height: 1.8, fontSize: 15),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {},

                      icon: const Icon(Icons.chat),

                      label: const Text("Contact Seller"),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,
        onTap: (index) {
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
