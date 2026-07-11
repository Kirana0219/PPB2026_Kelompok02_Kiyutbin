import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../model/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, this.onTap, this.width});

  final PostModel post;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,

      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.asset(
                  post.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 180,
                    width: double.infinity,
                    color: AppColors.primary.withValues(alpha: .12),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppColors.primary,
                      size: 44,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
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
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Rp ${post.price}",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            post.location,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
