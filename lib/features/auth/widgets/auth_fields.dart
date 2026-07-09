import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: AppTextStyles.label,
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,

          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          widget.label,
          style: AppTextStyles.label,
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: obscure,
          textInputAction: widget.textInputAction,

          decoration: InputDecoration(
            hintText: "••••••••",

            prefixIcon: const Icon(Icons.lock_outline),

            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

