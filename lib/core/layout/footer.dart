import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0x4CBFCABA),
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0C202124),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                index: 0,
                currentIndex: currentIndex,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: "Home",
                onTap: onTap,
              ),
            ),
            Expanded(
              child: _NavItem(
                index: 1,
                currentIndex: currentIndex,
                icon: Icons.event_outlined,
                activeIcon: Icons.event,
                label: "Event",
                onTap: onTap,
              ),
            ),
            Expanded(
              child: _NavItem(
                index: 2,
                currentIndex: currentIndex,
                icon: Icons.qr_code_scanner_outlined,
                activeIcon: Icons.qr_code_scanner,
                label: "Scan",
                onTap: onTap,
              ),
            ),
            Expanded(
              child: _NavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: Icons.article_outlined,
                activeIcon: Icons.article,
                label: "Blog",
                onTap: onTap,
              ),
            ),
            Expanded(
              child: _NavItem(
                index: 4,
                currentIndex: currentIndex,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: "Profile",
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(48),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color:
              selected ? const Color(0xFFD3E2ED) : Colors.transparent,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 22,
              color: selected
                  ? const Color(0xFF494551)
                  : const Color(0xFF3E4A3E),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: selected
                    ? const Color(0xFF494551)
                    : const Color(0xFF3E4A3E),
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight:
                    selected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}