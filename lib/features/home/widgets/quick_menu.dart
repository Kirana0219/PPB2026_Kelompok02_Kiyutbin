import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Access",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MenuItem(
              icon: Icons.edit_square,
              label: "Post",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.post);
              },
            ),

            _MenuItem(
              icon: Icons.event,
              label: "Event",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.events);
              },
            ),

            _MenuItem(
              icon: Icons.location_on,
              label: "Location",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.location);
              },
            ),

            _MenuItem(
              icon: Icons.article,
              label: "Blog",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.blog);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                color: Color(0xffEAF7EC),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Color(0xff0D631B), size: 28),
            ),

            const SizedBox(height: 10),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
