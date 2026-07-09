import 'package:flutter/material.dart';

import 'package:kiyutbin_mobile/core/theme/app_colors.dart';
import 'package:kiyutbin_mobile/core/theme/app_text_styles.dart';

/// Splash screen minimal — cuma tulisan "KIYUTBIN" di tengah layar.
/// Tampil selagi [AuthGate] masih mengecek session Supabase.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'KIYUTBIN',
          style: AppTextStyles.logo.copyWith(fontSize: 26),
        ),
      ),
    );
  }
}