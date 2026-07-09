import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';

class AuthService {
  AuthService();

  final SupabaseClient _supabase = Database.client;

  // ===============================
  // CURRENT USER
  // ===============================

  User? get currentUser => _supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  // ===============================
  // REGISTER
  // ===============================

  Future<AuthResponse> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user != null) {
      await _supabase.from('auth').insert({
        'id': user.id,
        'full_name': fullName,
        'email': email,
      });
    }

    return response;
  }

  // ===============================
  // LOGIN
  // ===============================

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ===============================
  // LOGOUT
  // ===============================

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // ===============================
  // GET PROFILE
  // ===============================

  Future<AuthModel> getProfile() async {
    final data = await _supabase
        .from('auth')
        .select()
        .eq('id', currentUser!.id)
        .single();

    return AuthModel.fromJson(data);
  }

  // ===============================
  // UPDATE PROFILE
  // ===============================

  Future<void> updateProfile({
    required String fullName,
    String? phone,
    String? photoUrl,
  }) async {
    await _supabase
        .from('auth')
        .update({
          'full_name': fullName,
          'phone': phone,
          'photo_url': photoUrl,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', currentUser!.id);
  }

  // ===============================
  // RESET PASSWORD
  // ===============================

  Future<void> resetPassword({
    required String email,
  }) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // ===============================
  // REFRESH SESSION
  // ===============================

  Future<AuthResponse> refreshSession() async {
    return await _supabase.auth.refreshSession();
  }

  // ===============================
  // DELETE ACCOUNT
  // ===============================

  Future<void> deleteProfile() async {
    await _supabase
        .from('auth')
        .delete()
        .eq('id', currentUser!.id);
  }
}