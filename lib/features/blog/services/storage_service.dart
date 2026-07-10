import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';

class StorageService {
  StorageService();

  final SupabaseClient _supabase = Database.client;

  static const String bucket = 'blog-thumbnail';

  /// ==========================
  /// Upload Thumbnail
  /// ==========================

  Future<String> uploadThumbnail(File imageFile) async {
    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}.jpg";

    final filePath = "thumbnails/$fileName";

    await _supabase.storage
        .from(bucket)
        .upload(
          filePath,
          imageFile,
          fileOptions: const FileOptions(
            upsert: true,
          ),
        );

    final imageUrl = _supabase.storage
        .from(bucket)
        .getPublicUrl(filePath);

    return imageUrl;
  }

  /// ==========================
  /// Delete Thumbnail
  /// ==========================

  Future<void> deleteThumbnail(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);

      final index = uri.pathSegments.indexOf(bucket);

      if (index == -1) return;

      final filePath =
          uri.pathSegments.sublist(index + 1).join('/');

      await _supabase.storage
          .from(bucket)
          .remove([filePath]);
    } catch (_) {}
  }
}