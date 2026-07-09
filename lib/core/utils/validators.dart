import 'package:email_validator/email_validator.dart';

class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email wajib diisi";
    }

    if (!EmailValidator.validate(value.trim())) {
      return "Format email tidak valid";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password wajib diisi";
    }

    if (value.length < 8) {
      return "Password minimal 8 karakter";
    }

    return null;
  }

  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName wajib diisi";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    final regex = RegExp(r'^[0-9]{10,15}$');

    if (!regex.hasMatch(digitsOnly)) {
      return "Nomor HP tidak valid";
    }

    return null;
  }

  static String? confirmPassword(
    String password,
    String? confirm,
  ) {
    if (confirm == null || confirm.isEmpty) {
      return "Konfirmasi password wajib diisi";
    }

    if (password != confirm) {
      return "Password tidak sama";
    }

    return null;
  }
}
