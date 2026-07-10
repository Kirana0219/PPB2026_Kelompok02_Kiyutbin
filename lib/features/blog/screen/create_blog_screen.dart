import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../auth/services/auth_service.dart';
import '../models/blog_model.dart';
import '../models/category_model.dart';
import '../services/blog_service.dart';
import '../services/category_service.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key, this.blog});

  final BlogModel? blog;

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final CategoryService _categoryService = CategoryService();
  final BlogService _blogService = BlogService();
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _contentController = TextEditingController();

  File? thumbnail;
  List<CategoryModel> categories = [];
  String? selectedCategory;
  bool isLoading = true;
  bool isPublishing = false;

  bool get isEditing => widget.blog != null;

  @override
  void initState() {
    super.initState();
    final blog = widget.blog;
    if (blog != null) {
      _titleController.text = blog.title;
      _shortDescriptionController.text = blog.shortDescription;
      _contentController.text = blog.content;
      selectedCategory = blog.categoryId;
    }
    loadCategory();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> loadCategory() async {
    try {
      final result = await _categoryService.getCategories();
      if (!mounted) return;
      setState(() {
        categories = result;
        if (selectedCategory != null &&
            !result.any((category) => category.id == selectedCategory)) {
          selectedCategory = null;
        }
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat kategori: $error')),
      );
    }
  }

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;
    setState(() => thumbnail = File(image.path));
  }

  Future<void> publishBlog() async {
    if (!isEditing && thumbnail == null) {
      _showMessage('Pilih thumbnail terlebih dahulu.');
      return;
    }
    if (_titleController.text.trim().isEmpty ||
        _shortDescriptionController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty ||
        selectedCategory == null) {
      _showMessage('Lengkapi semua kolom terlebih dahulu.');
      return;
    }

    setState(() => isPublishing = true);
    try {
      final existing = widget.blog;
      if (existing == null) {
        final profile = await _authService.getProfile();
        final now = DateTime.now();
        final blog = BlogModel(
          id: '',
          userId: profile.id,
          categoryId: selectedCategory!,
          title: _titleController.text.trim(),
          shortDescription: _shortDescriptionController.text.trim(),
          content: _contentController.text.trim(),
          thumbnailUrl: '',
          readTime: estimateReadTime(_contentController.text),
          isTrending: false,
          publishedAt: now,
          createdAt: now,
          updatedAt: now,
          authorName: profile.fullName,
          authorPhoto: profile.photoUrl,
          categoryName: '',
        );
        await _blogService.createBlogWithImage(blog: blog, image: thumbnail!);
      } else {
        final updatedBlog = existing.copyWith(
          categoryId: selectedCategory,
          title: _titleController.text.trim(),
          shortDescription: _shortDescriptionController.text.trim(),
          content: _contentController.text.trim(),
          readTime: estimateReadTime(_contentController.text),
          updatedAt: DateTime.now(),
        );
        await _blogService.updateBlogWithImage(
          blog: updatedBlog,
          newImage: thumbnail,
        );
      }

      if (!mounted) return;
      _showMessage(isEditing ? 'Blog berhasil diperbarui.' : 'Blog berhasil dibuat.');
      Navigator.pop(context, true);
    } catch (error) {
      if (mounted) _showMessage('Gagal menyimpan blog: $error');
    } finally {
      if (mounted) setState(() => isPublishing = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  int estimateReadTime(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return 1;
    return (trimmed.split(RegExp(r'\s+')).length / 200).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final existingImage = widget.blog?.thumbnailUrl ?? '';
    return Scaffold(
      appBar: const AppHeader(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing ? 'Edit Blog' : 'Create Blog',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: thumbnail != null
                            ? Image.file(thumbnail!, fit: BoxFit.cover)
                            : existingImage.isNotEmpty
                                ? Image.network(
                                    existingImage,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
                                  )
                                : _imagePlaceholder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: categories
                        .map((category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedCategory = value),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _shortDescriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Short Description'),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _contentController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isPublishing ? null : publishBlog,
                      child: isPublishing
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(isEditing ? 'Update' : 'Publish'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _imagePlaceholder() => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 50),
          SizedBox(height: 10),
          Text('Choose Thumbnail'),
        ],
      );
}
