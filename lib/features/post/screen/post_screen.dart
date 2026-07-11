import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';

import '../model/post_model.dart';
import '../services/post_service.dart';
import 'post_detail_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostService _postService = PostService();

  late Future<List<PostModel>> _posts;

  /// index Post tidak ada di Bottom Navigation,
  /// jadi gunakan Home sebagai default
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _posts = _postService.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppHeader(
        showBackButton: true,

        onNotification: () {
          Navigator.pushNamed(
            context,
            AppRouter.notification,
          );
        },

        onProfile: () {
          Navigator.pushNamed(
            context,
            AppRouter.profile,
          );
        },
      ),

      body: FutureBuilder<List<PostModel>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Belum ada artikel"),
            );
          }

          final posts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 20,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PostDetailScreen(post: post),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        if (post.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(12),
                            child: Image.network(
                              post.imageUrl,
                              height: 190,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) =>
                                      const SizedBox(),
                            ),
                          ),

                        const SizedBox(height: 16),

                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          post.content,
                          maxLines: 3,
                          overflow:
                              TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Dipublikasikan ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
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
              Navigator.pushNamed(
                context,
                AppRouter.scanner,
              );
              break;

            case 3:
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