import 'package:flutter/material.dart';

class CameraButtons extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCapture;
  final VoidCallback onFlash;
  final bool flashOn;

  const CameraButtons({
    super.key,
    required this.onGallery,
    required this.onCapture,
    required this.onFlash,
    required this.flashOn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        /// ======================
        /// GALLERY
        /// ======================

        _CircleButton(
          onTap: onGallery,
          icon: Icons.photo_library_rounded,
        ),

        /// ======================
        /// CAPTURE
        /// ======================

        GestureDetector(
          onTap: onCapture,
          child: Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
            ),
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        /// ======================
        /// FLASH
        /// ======================

        _CircleButton(
          onTap: onFlash,
          icon: flashOn
              ? Icons.flash_on_rounded
              : Icons.flash_off_rounded,
          iconColor:
              flashOn ? Colors.amber : Colors.white,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;

  const _CircleButton({
    required this.onTap,
    required this.icon,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 58,
          height: 58,
          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}