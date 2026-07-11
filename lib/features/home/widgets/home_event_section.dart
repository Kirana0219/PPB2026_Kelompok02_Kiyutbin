import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';
import 'section_header.dart';

class HomeEventSection extends StatefulWidget {
  const HomeEventSection({super.key});

  @override
  State<HomeEventSection> createState() => _HomeEventSectionState();
}

class _HomeEventSectionState extends State<HomeEventSection> {
  late final PageController _pageController;

  int currentIndex = 0;

  final List<_HomeEvent> events = const [
    _HomeEvent(
      title: "Beach Cleanup",
      date: "20 July 2026",
      image: "assets/images/events1.jpeg",
    ),
    _HomeEvent(
      title: "Tree Planting",
      date: "28 July 2026",
      image: "assets/images/events2.jpeg",
    ),
    _HomeEvent(
      title: "Save The Earth",
      date: "2 August 2026",
      image: "assets/images/events3.jpeg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.78,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Upcoming Events",
          onViewAll: () {
            Navigator.pushNamed(
              context,
              AppRouter.events,
            );
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            itemCount: events.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _EventCard(
                    event: events[index],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            events.length,
            (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.green
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final _HomeEvent event;

  const _EventCard({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
            child: Image.asset(
              event.image,
              height: 145,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      event.date,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeEvent {
  final String title;
  final String date;
  final String image;

  const _HomeEvent({
    required this.title,
    required this.date,
    required this.image,
  });
}