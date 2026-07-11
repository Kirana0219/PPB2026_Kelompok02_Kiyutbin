import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';
import '../../post/model/post_model.dart';
import '../../post/services/post_service.dart';
import '../../post/widgets/post_carousel.dart';
import 'section_header.dart';

class HomePostSection extends StatelessWidget {
  const HomePostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PostModel> posts =
        PostService.posts.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SectionHeader(
          title: "Trending Post",
          onViewAll: () {
            Navigator.pushNamed(
              context,
              AppRouter.post,
            );
          },
        ),

        const SizedBox(height: 16),

        PostCarousel(
          posts: posts,
          onTap: (post) {
            Navigator.pushNamed(
              context,
              AppRouter.postDetail,
              arguments: post,
            );
          },
        ),
      ],
    );
  }
}