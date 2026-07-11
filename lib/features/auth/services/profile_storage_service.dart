import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';

class ProfileStorageService {
  ProfileStorageService();

  static const String bucket = 'profile-photos';

  final SupabaseClient _supabase = Database.client;

  Future<String> uploadProfilePhoto({
    required String userId,
    required File imageFile,
  }) async {
    final filePath = '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _supabase.storage.from(bucket).upload(
          filePath,
          imageFile,
          fileOptions: const FileOptions(upsert: true),
        );
    return _supabase.storage.from(bucket).getPublicUrl(filePath);
  }

  Future<void> deleteProfilePhoto(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final bucketIndex = uri.pathSegments.indexOf(bucket);
      if (bucketIndex == -1) return;
      final filePath = uri.pathSegments.sublist(bucketIndex + 1).join('/');
      await _supabase.storage.from(bucket).remove([filePath]);
    } catch (_) {
      // Foto lama tidak boleh menggagalkan pembaruan profil.
    }
  }
}
