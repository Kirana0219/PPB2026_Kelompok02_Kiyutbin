import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:kiyutbin_mobile/core/constants/app_constants.dart';
import 'package:kiyutbin_mobile/core/theme/app_colors.dart';
import 'package:kiyutbin_mobile/core/theme/app_text_styles.dart';
import 'package:kiyutbin_mobile/core/utils/validators.dart';
import 'package:kiyutbin_mobile/features/auth/services/auth_service.dart';
import 'package:kiyutbin_mobile/features/auth/widgets/auth_button.dart';
import 'package:kiyutbin_mobile/features/auth/widgets/auth_components.dart';
import 'package:kiyutbin_mobile/features/auth/widgets/auth_fields.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // AuthGate akan otomatis pindah ke Home lewat onAuthStateChange
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Terjadi kesalahan. Silakan coba lagi.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError('Masukkan email terlebih dahulu.');
      return;
    }
    try {
      await _authService.resetPassword(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link reset password telah dikirim ke email kamu.')),
      );
    } catch (e) {
      _showError('Gagal mengirim email reset password.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(AppConstants.appName, style: AppTextStyles.logo),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE6F4EA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.eco_outlined, color: AppColors.primary, size: 56),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text('Welcome Back!', textAlign: TextAlign.center, style: AppTextStyles.heading),
                      const SizedBox(height: 4),
                      Text(
                        'Sign in to keep making an impact.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subtitle,
                      ),
                      const SizedBox(height: 28),

                      AuthTextField(
                        label: 'Email Address',
                        hint: 'name@example.com',
                        icon: Icons.mail_outline,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 16),

                      PasswordTextField(
                        label: 'Password',
                        controller: _passwordController,
                        validator: Validators.password,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RememberMe(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value ?? false),
                          ),
                          ForgotPasswordButton(onTap: _handleForgotPassword),
                        ],
                      ),
                      const SizedBox(height: 8),

                      AuthButton(text: 'Login', isLoading: _isLoading, onPressed: _handleLogin),
                      const SizedBox(height: 20),

                      AuthFooter(
                        question: "Don't have an account? ",
                        actionText: 'Sign Up',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}