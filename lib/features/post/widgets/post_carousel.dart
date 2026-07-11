import 'package:flutter/material.dart';

import '../model/post_model.dart';

class PostCarousel extends StatefulWidget {
  const PostCarousel({super.key, required this.posts, required this.onTap});

  final List<PostModel> posts;
  final Function(PostModel) onTap;

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  final PageController _controller = PageController(viewportFraction: .88);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,

          child: PageView.builder(
            controller: _controller,
            itemCount: widget.posts.length,

            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },

            itemBuilder: (context, index) {
              final post = widget.posts[index];

              return GestureDetector(
                onTap: () => widget.onTap(post),

                child: Container(
                  margin: const EdgeInsets.only(right: 16),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),

                    child: Stack(
                      fit: StackFit.expand,

                      children: [
                        /// IMAGE
                        Image.asset(
                          post.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: const Color(0xff2E7D32),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.white70,
                              size: 60,
                            ),
                          ),
                        ),

                        /// DARK OVERLAY
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,

                                Colors.black.withValues(alpha: .2),

                                Colors.black.withValues(alpha: .85),
                              ],
                            ),
                          ),
                        ),

                        /// CONTENT
                        Positioned(
                          left: 22,
                          right: 22,
                          bottom: 20,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: const Text(
                                  "Featured Item",
                                  style: TextStyle(
                                    color: Colors.white,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Rp ${post.price}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white70,
                                  ),

                                  const SizedBox(width: 4),

                                  Expanded(
                                    child: Text(
                                      post.location,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
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
            },
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: List.generate(
            widget.posts.length,

            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),

              margin: const EdgeInsets.symmetric(horizontal: 4),

              height: 8,

              width: currentPage == index ? 22 : 8,

              decoration: BoxDecoration(
                color: currentPage == index
                    ? const Color(0xff4CAF50)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
