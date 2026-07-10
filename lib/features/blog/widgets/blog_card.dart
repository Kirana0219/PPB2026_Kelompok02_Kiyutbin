import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/blog_model.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback? onTap;

  const BlogCard({
    super.key,
    required this.blog,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Thumbnail

            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: 190,
                width: double.infinity,
                child: blog.thumbnailUrl.isEmpty
                    ? const ColoredBox(
                        color: Color(0xFFEFEFEF),
                        child: Icon(Icons.image_outlined, size: 48),
                      )
                    : Image.network(
                        blog.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const ColoredBox(
                          color: Color(0xFFEFEFEF),
                          child: Icon(Icons.broken_image_outlined, size: 48),
                        ),
                      ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Category

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.12),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      blog.categoryName,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Title

                  Text(
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Description

                  Text(
                    blog.shortDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [

                      CircleAvatar(
                        radius: 18,
                        backgroundImage: (blog.authorPhoto?.isNotEmpty ?? false)
                            ? NetworkImage(blog.authorPhoto!)
                            : null,
                        child: (blog.authorPhoto?.isNotEmpty ?? false)
                            ? null
                            : const Icon(Icons.person),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              blog.authorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Text(
                              DateFormat(
                                "dd MMM yyyy",
                              ).format(blog.publishedAt),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [

                          const Icon(
                            Icons.schedule,
                            size: 18,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "${blog.readTime} min",
                          ),
                        ],
                      ),
                    ],
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
