import 'package:flutter/material.dart';

class RememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMe({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Checkbox(
          value: value,
          onChanged: onChanged,
        ),

        const Text("Remember Me"),
      ],
    );
  }
}

class AuthFooter extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(question),

        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: Color(0xFF0D631B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        child: const Text(
          "Forgot Password?",
        ),
      ),
    );
  }
}