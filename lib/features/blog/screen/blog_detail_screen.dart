import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;

  const BlogDetailScreen({
    super.key,
    required this.blogId,
  });

  @override
  State<BlogDetailScreen> createState() =>
      _BlogDetailScreenState();
}

class _BlogDetailScreenState
    extends State<BlogDetailScreen> {
  final BlogService _blogService = BlogService();

  BlogModel? blog;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBlog();
  }

  Future<void> loadBlog() async {
    try {
      final result =
          await _blogService.getBlogById(widget.blogId);

      if (!mounted) return;

      setState(() {
        blog = result;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : blog == null
              ? const Center(
                  child: Text("Blog not found"),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      /// Thumbnail

                      SizedBox(
                        width: double.infinity,
                        height: 260,
                        child: blog!.thumbnailUrl.isEmpty
                            ? const ColoredBox(
                                color: Color(0xFFEFEFEF),
                                child: Icon(Icons.image_outlined, size: 52),
                              )
                            : Image.network(
                                blog!.thumbnailUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const ColoredBox(
                                  color: Color(0xFFEFEFEF),
                                  child: Icon(Icons.broken_image_outlined, size: 52),
                                ),
                              ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            /// Category

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary
                                    .withOpacity(.15),
                                borderRadius:
                                    BorderRadius.circular(
                                        50),
                              ),
                              child: Text(
                                blog!.categoryName,
                                style:
                                    const TextStyle(
                                  color:
                                      AppColors.primary,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Title

                            Text(
                              blog!.title,
                              style: AppTextStyles.heading,
                            ),

                            const SizedBox(height: 20),

                            /// Author

                            Row(
                              children: [

                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: (blog!.authorPhoto?.isNotEmpty ?? false)
                                      ? NetworkImage(blog!.authorPhoto!)
                                      : null,
                                  child: (blog!.authorPhoto?.isNotEmpty ?? false)
                                      ? null
                                      : const Icon(Icons.person),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [

                                      Text(
                                        blog!
                                            .authorName,
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 4),

                                      Text(
                                        DateFormat(
                                                "dd MMM yyyy")
                                            .format(blog!
                                                .publishedAt),
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.grey,
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

                                    const SizedBox(
                                        width: 4),

                                    Text(
                                      "${blog!.readTime} min",
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            /// Content

                            Text(
                              blog!.content,
                              style:
                                  AppTextStyles.body.copyWith(
                                fontSize: 16,
                                height: 1.8,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
