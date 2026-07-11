import 'package:flutter/material.dart';

class PostSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const PostSectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const Spacer(),

          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text(
                "View All",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}
