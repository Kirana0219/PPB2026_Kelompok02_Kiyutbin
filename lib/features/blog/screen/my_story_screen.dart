import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../auth/services/auth_service.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';
import '../widgets/blog_card.dart';
import 'create_blog_screen.dart';

class MyStoryScreen extends StatefulWidget {
  const MyStoryScreen({super.key});

  @override
  State<MyStoryScreen> createState() => _MyStoryScreenState();
}

class _MyStoryScreenState extends State<MyStoryScreen> {
  final BlogService _blogService = BlogService();
  final AuthService _authService = AuthService();

  List<BlogModel> blogs = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadBlogs();
  }

  Future<void> loadBlogs() async {
    final user = _authService.currentUser;
    if (user == null) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Silakan login untuk melihat blog Anda.';
        });
      }
      return;
    }

    try {
      final result = await _blogService.getBlogsByUser(user.id);
      if (!mounted) return;
      setState(() {
        blogs = result;
        errorMessage = null;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Gagal memuat blog: $error';
        isLoading = false;
      });
    }
  }

  Future<void> editBlog(BlogModel blog) async {
    final didChange = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => CreateBlogScreen(blog: blog)),
    );
    if (didChange == true) await loadBlogs();
  }

  Future<void> deleteBlog(BlogModel blog) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus blog?'),
        content: Text('"${blog.title}" akan dihapus secara permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) return;

    try {
      await _blogService.deleteBlog(blog);
      if (!mounted) return;
      setState(() => blogs.removeWhere((item) => item.id == blog.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog berhasil dihapus.')),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus blog: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadBlogs,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'My Stories',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Kelola artikel yang telah Anda tulis.'),
                  const SizedBox(height: 24),
                  if (errorMessage != null)
                    Center(child: Text(errorMessage!))
                  else if (blogs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(child: Text('Anda belum membuat blog.')),
                    )
                  else
                    ...blogs.map(
                      (blog) => Column(
                        children: [
                          BlogCard(blog: blog),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Wrap(
                              spacing: 8,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () => editBlog(blog),
                                  icon: const Icon(Icons.edit_outlined),
                                  label: const Text('Edit'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () => deleteBlog(blog),
                                  icon: const Icon(Icons.delete_outline),
                                  label: const Text('Hapus'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
