import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';
import '../models/blog_model.dart';
import 'storage_service.dart';

class BlogService {
  BlogService();

  final SupabaseClient _supabase = Database.client;
  final StorageService _storage = StorageService();

  static const _blogSelect = '''
    *,
    profiles(full_name, photo_url),
    categories(name)
  ''';

  Future<List<BlogModel>> getAllBlogs() async {
    final response = await _supabase
        .from('blogs')
        .select(_blogSelect)
        .order('published_at', ascending: false);
    return response.map(BlogModel.fromJson).toList();
  }

  Future<List<BlogModel>> getTrendingBlogs() async {
    final response = await _supabase
        .from('blogs')
        .select(_blogSelect)
        .eq('is_trending', true)
        .order('published_at', ascending: false);
    return response.map(BlogModel.fromJson).toList();
  }

  Future<BlogModel> getBlogById(String id) async {
    final response = await _supabase
        .from('blogs')
        .select(_blogSelect)
        .eq('id', id)
        .single();
    return BlogModel.fromJson(response);
  }

  Future<List<BlogModel>> getBlogsByUser(String userId) async {
    final response = await _supabase
        .from('blogs')
        .select(_blogSelect)
        .eq('user_id', userId)
        .order('published_at', ascending: false);
    return response.map(BlogModel.fromJson).toList();
  }

  Future<void> createBlog(BlogModel blog) async {
    await _supabase.from('blogs').insert(blog.toInsertMap());
  }

  Future<void> updateBlog(String id, BlogModel blog) async {
    await _supabase.from('blogs').update(blog.toUpdateMap()).eq('id', id);
  }

  Future<void> createBlogWithImage({
    required BlogModel blog,
    required File image,
  }) async {
    String? imageUrl;
    try {
      imageUrl = await _storage.uploadThumbnail(image);
      await createBlog(blog.copyWith(thumbnailUrl: imageUrl));
    } catch (_) {
      if (imageUrl != null) await _storage.deleteThumbnail(imageUrl);
      rethrow;
    }
  }

  Future<void> deleteBlog(BlogModel blog) async {
    await _supabase.from('blogs').delete().eq('id', blog.id);
    if (blog.thumbnailUrl.isNotEmpty) {
      await _storage.deleteThumbnail(blog.thumbnailUrl);
    }
  }

  Future<void> updateBlogWithImage({
    required BlogModel blog,
    File? newImage,
  }) async {
    if (newImage == null) {
      await updateBlog(blog.id, blog);
      return;
    }

    final newImageUrl = await _storage.uploadThumbnail(newImage);
    final updatedBlog = blog.copyWith(thumbnailUrl: newImageUrl);
    try {
      await updateBlog(updatedBlog.id, updatedBlog);
    } catch (_) {
      await _storage.deleteThumbnail(newImageUrl);
      rethrow;
    }

    if (blog.thumbnailUrl.isNotEmpty) {
      await _storage.deleteThumbnail(blog.thumbnailUrl);
    }
  }
}
