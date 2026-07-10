import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../models/blog_model.dart';
import '../models/category_model.dart';
import '../services/blog_service.dart';
import '../services/category_service.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogService _blogService = BlogService();
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _searchController = TextEditingController();

  int currentIndex = 3;
  List<BlogModel> blogs = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;
  String? selectedCategoryId;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      final results = await Future.wait([
        _blogService.getAllBlogs(),
        _categoryService.getCategories(),
      ]);
      if (!mounted) return;
      setState(() {
        blogs = results[0] as List<BlogModel>;
        categories = results[1] as List<CategoryModel>;
        isLoading = false;
      });
    } catch (error) {
      debugPrint(error.toString());
      if (mounted) setState(() => isLoading = false);
    }
  }

  List<BlogModel> get filteredBlogs {
    final query = _searchQuery.toLowerCase().trim();
    return blogs.where((blog) {
      final matchesCategory =
          selectedCategoryId == null || blog.categoryId == selectedCategoryId;
      final matchesSearch = query.isEmpty ||
          blog.title.toLowerCase().contains(query) ||
          blog.shortDescription.toLowerCase().contains(query) ||
          blog.categoryName.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<BlogModel> get trendingBlogs {
    final trending = filteredBlogs.where((blog) => blog.isTrending).toList();
    return trending.isEmpty ? filteredBlogs.take(3).toList() : trending;
  }

  List<BlogModel> get latestBlogs {
    final latest = filteredBlogs.where((blog) => !blog.isTrending).toList();
    return latest.isEmpty ? filteredBlogs : latest;
  }

  void _openBlog(BlogModel blog) {
    Navigator.pushNamed(context, AppRouter.blogDetail, arguments: blog.id);
  }

  void _onBottomNavigationTap(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.home,
          (_) => false,
        );
        break;
      case 2:
        Navigator.pushNamed(context, AppRouter.scanner);
        break;
      case 1:
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Halaman ini belum tersedia.')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(showBackButton: false),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadData,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 23, 24, 100),
                children: [
                  _SearchField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    categories: categories,
                    selectedCategoryId: selectedCategoryId,
                    onCategorySelected: (id) => setState(() => selectedCategoryId = id),
                    onMyStories: () async {
                      await Navigator.pushNamed(context, AppRouter.myStories);
                      if (mounted) loadData();
                    },
                  ),
                  const SizedBox(height: 24),
                  if (filteredBlogs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(child: Text('No Blog Found')),
                    )
                  else ...[
                    const _SectionTitle(title: 'Trending'),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 306,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: trendingBlogs.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (_, index) => _TrendingCard(
                          blog: trendingBlogs[index],
                          onTap: () => _openBlog(trendingBlogs[index]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _SectionTitle(title: 'Latest Articles'),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              selectedCategoryId = null;
                            });
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...latestBlogs.map(
                      (blog) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _LatestArticleCard(
                          blog: blog,
                          onTap: () => _openBlog(blog),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,
        onTap: _onBottomNavigationTap,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.pushNamed(context, AppRouter.createBlog);
          if (mounted) loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    required this.onMyStories,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;
  final VoidCallback onMyStories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F1),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 9, offset: Offset(0, 4)),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search recyclable products..',
          hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: AppColors.textSecondary),
            onSelected: (value) {
              if (value == 'stories') {
                onMyStories();
              } else {
                onCategorySelected(value == 'all' ? null : value.substring(4));
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'stories', child: Text('My Stories')),
              const PopupMenuDivider(),
              CheckedPopupMenuItem(
                value: 'all',
                checked: selectedCategoryId == null,
                child: const Text('All categories'),
              ),
              ...categories.map(
                (category) => CheckedPopupMenuItem(
                  value: 'cat:${category.id}',
                  checked: selectedCategoryId == category.id,
                  child: Text(category.name),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      );
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.blog, required this.onTap});

  final BlogModel blog;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BlogImage(url: blog.thumbnailUrl, height: 178, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryLabel(name: blog.categoryName),
                    const SizedBox(height: 7),
                    Text(
                      blog.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, height: 1.25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    _ReadTime(blog: blog),
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

class _LatestArticleCard extends StatelessWidget {
  const _LatestArticleCard({required this.blog, required this.onTap});

  final BlogModel blog;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _BlogImage(url: blog.thumbnailUrl, height: 80, width: 80, borderRadius: BorderRadius.circular(12)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryLabel(name: blog.categoryName),
                    const SizedBox(height: 5),
                    Text(
                      blog.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, height: 1.35, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('MMM d').format(blog.publishedAt)} | ${blog.readTime} min read',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
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

class _CategoryLabel extends StatelessWidget {
  const _CategoryLabel({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: const Color(0xFFE6F4E7), borderRadius: BorderRadius.circular(8)),
        child: Text(
          name.isEmpty ? 'Article' : name,
          style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );
}

class _ReadTime extends StatelessWidget {
  const _ReadTime({required this.blog});

  final BlogModel blog;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.schedule_outlined, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text('${blog.readTime} min read', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ],
      );
}

class _BlogImage extends StatelessWidget {
  const _BlogImage({required this.url, required this.height, this.width, required this.borderRadius});

  final String url;
  final double height;
  final double? width;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: url.isEmpty
              ? const ColoredBox(
                  color: Color(0xFFE7E9E7),
                  child: Icon(Icons.image_outlined, color: AppColors.hint),
                )
              : Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: Color(0xFFE7E9E7),
                    child: Icon(Icons.broken_image_outlined, color: AppColors.hint),
                  ),
                ),
        ),
      );
}
