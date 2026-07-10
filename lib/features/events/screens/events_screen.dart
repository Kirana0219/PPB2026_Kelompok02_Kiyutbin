import 'package:flutter/material.dart';

import 'package:kiyutbin_mobile/core/layout/widgets/app_bottom.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_header.dart';
import 'package:kiyutbin_mobile/core/routes/app_router.dart';
import 'package:kiyutbin_mobile/features/events/widgets/calendar_section.dart';
import 'package:kiyutbin_mobile/features/events/widgets/other_event_section.dart';
import 'package:kiyutbin_mobile/features/events/widgets/registered_events_section.dart';
import 'package:kiyutbin_mobile/features/events/widgets/todays_event_section.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DateTime selectedDate = DateTime.now();

  void _onBottomNavigationTap(int index) {
    if (index == 1) return;

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.home,
          (_) => false,
        );
        break;

      case 2:
        Navigator.pushNamed(
          context,
          AppRouter.scanner,
        );
        break;

      case 3:
        Navigator.pushNamed(
          context,
          AppRouter.blog,
        );
        break;

      case 4:
        Navigator.pushNamed(
          context,
          AppRouter.profile,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppHeader(
        showBackButton: false,
        onNotification: () {
          // TODO: Notification
        },
        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarSection(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),

              const SizedBox(height: 24),

              const RegisteredEventsSection(),

              const SizedBox(height: 30),

              const TodaysEventsSection(),

              const SizedBox(height: 24),

              const OtherEventsSection(),

              const SizedBox(height: 150),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: 1,
        onTap: _onBottomNavigationTap,
      ),
    );
  }
}