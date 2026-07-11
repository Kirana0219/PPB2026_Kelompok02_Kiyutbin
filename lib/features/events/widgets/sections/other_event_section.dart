import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kiyutbin_mobile/features/events/models/event_model.dart';
import 'package:kiyutbin_mobile/features/events/services/event_service.dart';
import 'package:kiyutbin_mobile/features/events/widgets/cards/event_card.dart';


class OtherEventsSection extends StatefulWidget {
  const OtherEventsSection({super.key});

  @override
  State<OtherEventsSection> createState() =>
  _OtherEventsSectionState();
}


class _OtherEventsSectionState
    extends State<OtherEventsSection> {

  final EventService _eventService = EventService();

  late final List<EventModel> _otherEvents;

  final PageController _pageController = PageController(
    viewportFraction: 0.75,
  );


  @override
  void initState() {
    super.initState();

    _otherEvents =
    _eventService.getOtherEvents();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildHeader(),

        const SizedBox(height: 16),

        _buildPageView(),

        const SizedBox(height: 8),

        _buildIndicator(),

      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
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
              // TODO: View All Other Events
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
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _otherEvents.length,
        itemBuilder: (context, index) {

          final event = _otherEvents[index];

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 20 : 8,
              right: index == _otherEvents.length - 1
                  ? 20
                  : 8,
            ),
            child: EventCard(
              event: event,
              showStatus: false,
              onTap: () {
                // TODO:
                // Event Detail
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _otherEvents.length,
        (index) => AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {

            int currentPage = 0;

            if (_pageController.hasClients &&
                _pageController.page != null) {
              currentPage =
                  _pageController.page!.round();
            }

            final isActive = currentPage == index;

            return AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              width: isActive ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF0D631B)
                    : const Color(0xFFD6D6D6),
                borderRadius:
                    BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}