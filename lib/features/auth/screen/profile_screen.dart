import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_bottom.dart';
import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  AuthModel? _profile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _authService.getProfile();
      if (!mounted) return;
      setState(() {
        _profile = profile;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat profil: $error';
      });
    }
  }

  Future<void> _editProfile() async {
    final profile = _profile;
    if (profile == null) return;
    final didUpdate = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => EditProfileScreen(profile: profile)),
    );
    if (didUpdate == true) await _loadProfile();
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Anda akan keluar dari akun ini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (shouldLogout != true) return;

    try {
      await _authService.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (_) => false);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal logout: $error')),
        );
      }
    }
  }

  void _onBottomNavigationTap(int index) {
    if (index == 4) return;
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (_) => false);
        break;
      case 2:
        Navigator.pushNamed(context, AppRouter.scanner);
        break;
      case 3:
        Navigator.pushNamed(context, AppRouter.blog);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Halaman ini belum tersedia.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(
        showBackButton: true,
        showProfileAvatar: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : RefreshIndicator(
                  onRefresh: _loadProfile,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: const Color(0xFFF0F1F1),
                              backgroundImage: profile!.photoUrl?.isNotEmpty == true
                                  ? NetworkImage(profile.photoUrl!)
                                  : null,
                              child: profile.photoUrl?.isNotEmpty == true
                                  ? null
                                  : const Icon(Icons.person, size: 48, color: AppColors.hint),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              profile.fullName,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE6E7E6)),
                          boxShadow: const [
                            BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 5)),
                          ],
                        ),
                        child: Column(
                          children: [
                            _ProfileMenuItem(
                              icon: Icons.person_outline,
                              title: 'Edit Profile',
                              onTap: _editProfile,
                            ),
                            const Divider(height: 1),
                            _ProfileMenuItem(
                              icon: Icons.article_outlined,
                              title: 'My Blog',
                              onTap: () => Navigator.pushNamed(context, AppRouter.myStories),
                            ),
                            const Divider(height: 1),
                            _ProfileMenuItem(
                              icon: Icons.logout,
                              title: 'Logout',
                              isDestructive: true,
                              onTap: _logout,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: AppFooter(currentIndex: 4, onTap: _onBottomNavigationTap),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFB3261E) : AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: TextStyle(color: color, fontSize: 16))),
            if (!isDestructive) Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}
