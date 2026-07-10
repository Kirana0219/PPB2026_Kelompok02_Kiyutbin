import 'package:flutter/material.dart';

import 'package:kiyutbin_mobile/features/splash/screen/auth_gate.dart';

//splash
import '../../features/splash/screen/splash_screen.dart';
// Auth
import '../../features/auth/screen/login_screen.dart';
import '../../features/auth/screen/register_screen.dart';

// Scanner
import '../../features/qr_scanner/screen/scanner_screen.dart';

class AppRouter {
  AppRouter._();

  // Route Names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String scanner = '/scanner';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
        case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case AppRouter.home:
        return MaterialPageRoute(
          builder: (_) => const AuthGate(),
        );

      case AppRouter.scanner:
        return MaterialPageRoute(
          builder: (_) => const ScannerScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}