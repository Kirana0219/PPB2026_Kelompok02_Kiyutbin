import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'other_event_card.dart';

class OtherEventsSection extends StatefulWidget {
  const OtherEventsSection({super.key});

  @override
  State<OtherEventsSection> createState() =>
      _OtherEventsSectionState();
}

class _OtherEventsSectionState extends State<OtherEventsSection> {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  final List<Map<String, String>> otherEvents = [
    {
      'image':
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      'title': 'AI & Machine Learning Conference',
      'location': 'Innovation Hall',
      'time': 'Saturday, 10:00 AM - 03:00 PM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=800',
      'title': 'Creative Design Workshop',
      'location': 'Creative Room A',
      'time': 'Sunday, 09:00 AM - 12:00 PM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=800',
      'title': 'Technology Exhibition',
      'location': 'Main Exhibition Center',
      'time': 'Next Week, 01:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Other Events',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1C1B1F),
                ),
              ),

              TextButton(
                onPressed: () {
                  // TODO: Navigate to View All
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0D631B),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: otherEvents.length,
            itemBuilder: (context, index) {
              final event = otherEvents[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == otherEvents.length - 1 ? 20 : 8,
                ),
                child: OtherEventCard(
                  imageUrl: event['image']!,
                  title: event['title']!,
                  location: event['location']!,
                  dateTime: event['time']!,
                  onTap: () {
                    // TODO: Navigate to Event Detail
                  },
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            otherEvents.length,
            (index) => AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                int currentPage = 0;

                if (_pageController.hasClients &&
                    _pageController.page != null) {
                  currentPage = _pageController.page!.round();
                }

                final isActive = currentPage == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF0D631B)
                        : const Color(0xFFD6D6D6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}