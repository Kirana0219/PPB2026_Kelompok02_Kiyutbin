import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kiyutbin_mobile/features/events/widgets/registered_events_card.dart';

class RegisteredEventsSection extends StatefulWidget {
  const RegisteredEventsSection({super.key});

  @override
  State<RegisteredEventsSection> createState() =>
      _RegisteredEventsSectionState();
}

class _RegisteredEventsSectionState
    extends State<RegisteredEventsSection> {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  final List<Map<String, String>> registeredEvents = [
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
      'title': 'Flutter Developer Meetup',
      'location': 'Room C203',
      'time': 'Tomorrow, 09:00 AM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      'title': 'AI & Machine Learning Conference',
      'location': 'Innovation Hall',
      'time': 'Friday, 01:00 PM',
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
                'Registered Events',
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
          height: 270,
          child: PageView.builder(
            controller: _pageController,
            itemCount: registeredEvents.length,
            itemBuilder: (context, index) {
              final event = registeredEvents[index];

              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 8),
                child: RegisteredEventCard(
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

        const SizedBox(height: 8),
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            registeredEvents.length,
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