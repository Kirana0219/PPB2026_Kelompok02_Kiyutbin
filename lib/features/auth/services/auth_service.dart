import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/database.dart';
import '../models/auth_model.dart';

class AuthService {
  AuthService();

  final SupabaseClient _supabase = Database.client;

  User? get currentUser => _supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  // ==========================
  // REGISTER
  // ==========================

  Future<AuthResponse> signUp({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final session = response.session;
    final user = response.user;

    if (user == null) {
      throw Exception('User gagal dibuat.');
    }

    // Jika confirm email aktif maka session null
    // Flutter tidak bisa membuat profile sekarang.
    if (session == null) {
      return response;
    }

    // Ambil user yang benar-benar sudah login
    final authUser = _supabase.auth.currentUser;

    if (authUser == null) {
      throw Exception("Session tidak ditemukan.");
    }

    // Cek apakah profile sudah ada
    final existing = await _supabase
        .from('profiles')
        .select('id')
        .eq('id', authUser.id)
        .maybeSingle();

    if (existing == null) {
      await _supabase.from('profiles').insert({
        'id': authUser.id,
        'full_name': fullName,
        'email': email,
        'phone': phone,
      });
    }

    return response;
  }

  // ==========================
  // LOGIN
  // ==========================

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ==========================
  // LOGOUT
  // ==========================

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // ==========================
  // GET PROFILE
  // ==========================

  Future<AuthModel> getProfile() async {
    final user = currentUser;

    if (user == null) {
      throw Exception("User belum login.");
    }

    final data = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return AuthModel.fromJson(data);
  }

  // ==========================
  // UPDATE PROFILE
  // ==========================

  Future<void> updateProfile({
    required String fullName,
    String? phone,
    String? photoUrl,
  }) async {
    final user = currentUser;

    if (user == null) {
      throw Exception("User belum login.");
    }

    await _supabase.from('profiles').update({
      'full_name': fullName,
      'phone': phone,
      'photo_url': photoUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);
  }

  // ==========================
  // RESET PASSWORD
  // ==========================

  Future<void> resetPassword({
    required String email,
  }) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // ==========================
  // REFRESH SESSION
  // ==========================

  Future<AuthResponse> refreshSession() async {
    return await _supabase.auth.refreshSession();
  }

  // ==========================
  // DELETE PROFILE
  // ==========================

  Future<void> deleteProfile() async {
    final user = currentUser;

    if (user == null) {
      throw Exception("User belum login.");
    }

    await _supabase.from('profiles').delete().eq('id', user.id);
  }
}