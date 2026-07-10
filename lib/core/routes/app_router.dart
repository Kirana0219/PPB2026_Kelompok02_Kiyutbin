import 'package:flutter/material.dart';

import 'package:kiyutbin_mobile/features/splash/screen/auth_gate.dart';

//splash
import '../../features/splash/screen/splash_screen.dart';
// Auth
import '../../features/auth/screen/login_screen.dart';
import '../../features/auth/screen/register_screen.dart';

// Scanner
import '../../features/qr_scanner/screen/scanner_screen.dart';

//blog
import '../../features/blog/screen/blog_screen.dart';
import '../../features/blog/screen/blog_detail_screen.dart';
import '../../features/blog/screen/create_blog_screen.dart';
import '../../features/blog/screen/my_story_screen.dart';

class AppRouter {
  AppRouter._();

  // Route Names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String scanner = '/scanner';
  static const String blog = '/blog';
  static const String blogDetail = '/blog/detail';
  static const createBlog = "/create-blog";
  static const String myStories = '/blog/my-stories';

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

      case AppRouter.blog:
        return MaterialPageRoute(
          builder: (_) => const BlogScreen(),
        );

      case AppRouter.blogDetail:
        final blogId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => BlogDetailScreen(
            blogId: blogId,
          ),
        );

      case AppRouter.createBlog:
        return MaterialPageRoute(
          builder: (_) => const CreateBlogScreen(),
        );

      case AppRouter.myStories:
        return MaterialPageRoute(
          builder: (_) => const MyStoryScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}
