import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:kiyutbin_mobile/core/config/database.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';
import 'package:kiyutbin_mobile/features/auth/screen/login_screen.dart';
import 'package:kiyutbin_mobile/features/auth/services/auth_service.dart';
import 'package:kiyutbin_mobile/features/splash/screen/home_dummy.dart';

// TODO: sesuaikan import Home screen kamu di bawah kalau sudah dibuat
// import 'package:kiyutbin_mobile/features/home/screen/home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _authService = AuthService();

  Future<AuthModel>? _profileFuture;
  String? _cachedUserId;

  Future<AuthModel> _profileFutureFor(String userId) {
    if (_cachedUserId != userId || _profileFuture == null) {
      _cachedUserId = userId;
      _profileFuture = _authService.getProfile();
    }
    return _profileFuture!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Database.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = Database.client.auth.currentSession;

        if (session == null) {
          _cachedUserId = null;
          _profileFuture = null;
          return const LoginScreen();
        }

        return FutureBuilder<AuthModel>(
          future: _profileFutureFor(session.user.id),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (profileSnapshot.hasError) {
              // Profile tidak ditemukan (dihapus manual dari database)
              Database.client.auth.signOut();
              return const LoginScreen();
            }

            final profile = profileSnapshot.data!;

            // TODO: ganti dengan home screen kamu
            // return HomeScreen(profile: profile);
            return HomeDummy(
              profile: profile,
            );
          },
        );
      },
    );
  }
}