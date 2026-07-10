import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNotification;
  final VoidCallback? onProfile;

  final bool showBackButton;
  final bool showNotificationDot;
  final bool showProfileAvatar;

  /// Path asset foto profile
  final String? profileImage;
  final String? profileImageUrl;

  const AppHeader({
    super.key,
    this.onBack,
    this.onNotification,
    this.onProfile,
    this.showBackButton = true,
    this.showNotificationDot = true,
    this.showProfileAvatar = true,
    this.profileImage,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,

      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // ================= BACK BUTTON =================

              SizedBox(
                width: 40,
                height: 40,
                child: showBackButton
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: onBack ?? () => Navigator.pop(context),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: Color(0xFF202124),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // ================= RIGHT =================

              Row(
                children: [

                  // Notification

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: onNotification,
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            const Icon(
                              Icons.notifications_none_rounded,
                              size: 24,
                              color: Color(0xFF202124),
                            ),

                            if (showNotificationDot)
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBA1A1A),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFF8F9FB),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  if (showProfileAvatar) ...[
                    const SizedBox(width: 4),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: onProfile,
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF0D631B),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: profileImageUrl?.isNotEmpty == true
                                ? Image.network(
                                    profileImageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _avatarPlaceholder(),
                                  )
                                : profileImage != null
                                    ? Image.asset(
                                        profileImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : _avatarPlaceholder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);

  Widget _avatarPlaceholder() => const ColoredBox(
        color: Color(0xFFF2F2F2),
        child: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      );
}
