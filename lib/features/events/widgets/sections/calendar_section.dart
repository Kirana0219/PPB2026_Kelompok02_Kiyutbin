import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class CalendarSection extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarSection({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarSection> createState() =>
      _CalendarSectionState();
}


class _CalendarSectionState extends State<CalendarSection> {
  static const int _basePage = 5000;
  late final PageController _controller;
  late final DateTime _initialWeek;
  late DateTime _currentWeek;


  @override
  void initState() {
    super.initState();

    _initialWeek =
        _startOfWeek(widget.selectedDate);

    _currentWeek = _initialWeek;

    _controller = PageController(
      initialPage: _basePage,
    );
  }


  DateTime _startOfWeek(DateTime date) {
    return date.subtract(
      Duration(
        days: date.weekday - 1,
      ),
    );
  }


  List<DateTime> _generateWeek(DateTime start) {
    return List.generate(
      7,
      (index) => start.add(
        Duration(days: index),
      ),
    );
  }

    @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildHeader(),

        const SizedBox(height: 12),

        SizedBox(
          height: 90,
          child: PageView.builder(
            controller: _controller,

            onPageChanged: (page) {
              final difference = page - _basePage;

              setState(() {
                _currentWeek = _initialWeek.add(
                  Duration(
                    days: difference * 7,
                  ),
                );
              });
            },

            itemBuilder: (context, index) {

              final difference =
                  index - _basePage;

              final startWeek =
                  _initialWeek.add(
                    Duration(
                      days: difference * 7,
                    ),
                  );

              final days =
                  _generateWeek(startWeek);


              return Row(
                children: days.map(
                  (date) {

                    return Expanded(
                      child: GestureDetector(
                        behavior:
                            HitTestBehavior.opaque,

                        onTap: () {
                          widget.onDateSelected(
                            date,
                          );
                        },

                        child: Center(
                          child: CalendarCard(
                            date: date,

                            isSelected:
                                DateUtils.isSameDay(
                              date,
                              widget.selectedDate,
                            ),

                            hasEvent: false,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildHeader() {
    return Text(
      DateFormat('MMMM yyyy')
          .format(_currentWeek),

      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


class CalendarCard extends StatelessWidget {

  final DateTime date;
  final bool isSelected;
  final bool hasEvent;


  const CalendarCard({
    super.key,
    required this.date,
    required this.isSelected,
    required this.hasEvent,
  });


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),

      width: 42,

      height: isSelected
          ? 82
          : 72,

      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF0D631B)
            : const Color(0xFFEDEEEF),

        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Text(
            DateFormat('EEE')
                .format(date)
                .toUpperCase(),

            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight:
                  FontWeight.w500,

              color: isSelected
                  ? Colors.white
                  : const Color(
                      0xFF3E4A3E,
                    ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            DateFormat('d')
                .format(date),

            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight:
                  FontWeight.w700,

              color: isSelected
                  ? Colors.white
                  : const Color(
                      0xFF3E4A3E,
                    ),
            ),
          ),

          const SizedBox(height: 6),

          if (hasEvent)

            Container(
              width: 5,
              height: 5,

              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : const Color(
                        0xFF0D631B,
                      ),

                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}