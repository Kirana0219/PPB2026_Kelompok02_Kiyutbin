import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../../core/theme/app_colors.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import '../services/profile_storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});

  final AuthModel profile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthService _authService = AuthService();
  final ProfileStorageService _storageService = ProfileStorageService();
  final ImagePicker _picker = ImagePicker();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  File? _selectedPhoto;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.fullName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null && mounted) setState(() => _selectedPhoto = File(image.path));
  }

  Future<void> _saveProfile() async {
    final fullName = _nameController.text.trim();
    if (fullName.isEmpty) {
      _showMessage('Nama tidak boleh kosong.');
      return;
    }
    final email = _emailController.text.trim();
    if (!EmailValidator.validate(email)) {
      _showMessage('Masukkan alamat email yang valid.');
      return;
    }

    setState(() => _isSaving = true);
    String? newPhotoUrl;
    try {
      if (_selectedPhoto != null) {
        newPhotoUrl = await _storageService.uploadProfilePhoto(
          userId: widget.profile.id,
          imageFile: _selectedPhoto!,
        );
      }

      if (email != widget.profile.email) {
        await _authService.updateEmail(email);
      }

      await _authService.updateProfile(
        fullName: fullName,
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        photoUrl: newPhotoUrl ?? widget.profile.photoUrl,
      );

      if (newPhotoUrl != null &&
          widget.profile.photoUrl != null &&
          widget.profile.photoUrl!.isNotEmpty) {
        await _storageService.deleteProfilePhoto(widget.profile.photoUrl!);
      }

      if (!mounted) return;
      _showMessage('Profil berhasil diperbarui.');
      Navigator.pop(context, true);
    } catch (error) {
      if (newPhotoUrl != null) await _storageService.deleteProfilePhoto(newPhotoUrl);
      if (mounted) _showMessage('Gagal menyimpan profil: $error');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  ImageProvider<Object>? get _profileImage {
    if (_selectedPhoto != null) return FileImage(_selectedPhoto!);
    final photoUrl = widget.profile.photoUrl;
    if (photoUrl?.isNotEmpty ?? false) return NetworkImage(photoUrl!);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = widget.profile.photoUrl;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        showNotificationDot: false,
        showProfileAvatar: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 28),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: const Color(0xFFE7E9E7),
                    backgroundImage: _profileImage,
                    child: _selectedPhoto == null && !(photoUrl?.isNotEmpty ?? false)
                        ? const Icon(Icons.person, size: 56, color: AppColors.hint)
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: AppColors.primary,
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: _pickPhoto,
                        icon: const Icon(Icons.edit, color: Colors.white, size: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 36),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveProfile,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: _isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
