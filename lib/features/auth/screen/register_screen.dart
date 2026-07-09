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

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
  if (!_formKey.currentState!.validate()) return;

  if (!_agreedToTerms) {
    _showError(
      'Kamu harus menyetujui Terms & Privacy Policy terlebih dahulu.',
    );
    return;
  }

  setState(() => _isLoading = true);

  try {
    await _authService.signUp(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil dibuat.'),
        backgroundColor: Colors.green,
      ),
    );

    // Karena Confirm Email OFF,
    // AuthGate akan otomatis mendeteksi session login.
    Navigator.of(context).popUntil((route) => route.isFirst);
  } on AuthException catch (e) {
    _showError(e.message);
  } on PostgrestException catch (e) {
    _showError(e.message);
  } catch (e) {
    _showError(e.toString());
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
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
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.screenPadding,
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
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
                  // Ilustrasi lingkaran hijau
                  // TODO: ganti dengan Image.asset('assets/illustrations/create_account.png')
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6F4EA),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.eco_outlined,
                        color: AppColors.primary,
                        size: 56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Let's Save Our Earth!",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 28),

                  AuthTextField(
                    label: 'Full Name',
                    hint: 'Jane Doe',
                    icon: Icons.person_outline,
                    controller: _fullNameController,
                    validator: (value) => Validators.required(value, 'Nama lengkap'),
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    label: 'Email',
                    hint: 'jane@example.com',
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    label: 'Phone Number',
                    hint: '+1 (555) 000-0000',
                    icon: Icons.phone_outlined,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validators.phone,
                  ),
                  const SizedBox(height: 16),

                  PasswordTextField(
                    label: 'Password',
                    controller: _passwordController,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: _agreedToTerms,
                          activeColor: AppColors.primary,
                          onChanged: (value) =>
                              setState(() => _agreedToTerms = value ?? false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.body,
                            children: const [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms & Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  AuthButton(
                    text: 'Create Account',
                    isLoading: _isLoading,
                    onPressed: _handleRegister,
                  ),
                  const SizedBox(height: 20),

                  AuthFooter(
                    question: 'Already have an account? ',
                    actionText: 'Sign In',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}