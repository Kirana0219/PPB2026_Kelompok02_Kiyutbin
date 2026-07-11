import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';

class HomeEventSection extends StatelessWidget {
  const HomeEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.events);
              },
              child: const Text("View All"),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 230,

          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            itemBuilder: (_, index) => _EventCard(event: events[index]),

            separatorBuilder: (_, __) => const SizedBox(width: 16),

            itemCount: events.length,
          ),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final _HomeEvent event;

  const _EventCard({required this.event});

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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),

            child: Image.asset(
              event.image,
              height: 145,
              width: double.infinity,
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
                      style: const TextStyle(color: Colors.grey),
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
