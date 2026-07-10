import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'todays_event_card.dart';

class TodaysEventsSection extends StatefulWidget {
  const TodaysEventsSection({super.key});

  @override
  State<TodaysEventsSection> createState() => _TodaysEventsSectionState();
}

class _TodaysEventsSectionState extends State<TodaysEventsSection> {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> todaysEvents = [
      {
        'image':
            'https://images.unsplash.com/photo-1511578314322-379afb476865?w=800',
        'title': 'Tech Innovators Summit',
        'location': 'Main Auditorium, Building A',
        'time': 'Today, 2:00 PM - 5:30 PM',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800',
        'title': 'Flutter Community Meetup',
        'location': 'Room C203',
        'time': 'Today, 6:30 PM - 8:30 PM',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Events",
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
          height: 290,
          child: PageView.builder(
            controller: _pageController,
            itemCount: todaysEvents.length,
            itemBuilder: (context, index) {
              final event = todaysEvents[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == todaysEvents.length - 1 ? 20 : 8,
                ),
                child: TodaysEventCard(
                  imageUrl: event['image']!,
                  title: event['title']!,
                  location: event['location']!,
                  dateTime: event['time']!,
                  onTap: () {},
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            todaysEvents.length,
            (index) => AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                int currentPage = 0;

                if (_pageController.hasClients &&
                    _pageController.page != null) {
                  currentPage = _pageController.page!.round();
                }

                final active = currentPage == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFF0D631B)
                        : const Color(0xFFD6D6D6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

