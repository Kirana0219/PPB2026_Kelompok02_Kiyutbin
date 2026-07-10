import 'package:flutter/material.dart';
import 'package:kiyutbin_mobile/core/layout/widgets/app_bottom.dart';
import 'package:kiyutbin_mobile/features/auth/models/auth_model.dart';
import 'package:kiyutbin_mobile/features/home/screen/home_screen.dart';
import 'package:kiyutbin_mobile/features/events/widgets/registered_events_section.dart';
import 'package:kiyutbin_mobile/features/events/widgets/todays_event_section.dart';
import 'package:kiyutbin_mobile/features/events/widgets/other_event_section.dart';

import '../widgets/calendar_section.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.profile});

  final AuthModel profile;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DateTime selectedDate = DateTime.now();
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Events"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SECTION 1
              CalendarSection(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),

              /// SECTION 2
              const SizedBox(height: 24),

              const RegisteredEventsSection(),

              const SizedBox(height: 24),

              const SizedBox(height: 30),

              /// SECTION 3

              const TodaysEventsSection(),

              const SizedBox(height: 24),

              /// SECTION 4

              const OtherEventsSection(),

              const SizedBox(height: 150),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(profile: widget.profile),
                ),
              );
              break;

            case 1:
              break;

            case 2:
              // TODO Scan
              break;

            case 3:
              // TODO Blog
              break;

            case 4:
              // TODO Profile
              break;
          }
        },
      ),
    );
  }
}

