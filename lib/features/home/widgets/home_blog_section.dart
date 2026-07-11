import 'package:flutter/material.dart';
import '../../../core/routes/app_router.dart';
import '../../blog/models/blog_model.dart';
import '../../blog/services/blog_service.dart';
import 'section_header.dart';

class HomeBlogSection extends StatefulWidget {
  const HomeBlogSection({super.key});
  @override
  State<HomeBlogSection> createState() => _HomeBlogSectionState();
}
class _HomeBlogSectionState extends State<HomeBlogSection> {
  final BlogService _blogService = BlogService();
  bool isLoading = true;
  List<BlogModel> blogs = [];
  @override
  void initState() {
    super.initState();
    loadBlogs();
  }

  Future<void> loadBlogs() async {
    try {
      final result = await _blogService.getAllBlogs();
      if (!mounted) return;
      setState(() {
        blogs = result.take(3).toList();
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Latest Blogs",
          onViewAll: () {
            Navigator.pushNamed(
              context,
              AppRouter.blog,
            );
          },
        ),
        const SizedBox(height: 16),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (blogs.isEmpty)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(25),
            child: const Text(
              "No blog available",
            ),
          )
        else
          Column(
            children: blogs.map((blog) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _HomeBlogCard(
                  blog: blog,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _HomeBlogCard extends StatelessWidget {
  final BlogModel blog;
  const _HomeBlogCard({
    required this.blog,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.blogDetail,
          arguments: blog.id,
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(18),
              ),
              child: Image.network(
                blog.thumbnailUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 110,
                    height: 110,
                    color: Colors.grey,
                    child: const Icon(
                      Icons.image,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        blog.categoryName,
                        style: const TextStyle(
                          color: Color(0xff0D631B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      blog.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${blog.readTime} min read",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}