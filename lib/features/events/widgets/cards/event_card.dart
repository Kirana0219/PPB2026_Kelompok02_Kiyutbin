import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;

  /// Lebar card.
  /// Kalau null, card akan mengikuti parent.
  final double? width;

  /// Tinggi gambar.
  final double imageHeight;

  /// Menampilkan status atau tidak.
  final bool showStatus;

  const EventCard({
    super.key,
    required this.event,
    this.onTap,
    this.width,
    this.imageHeight = 180,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(
                  Icons.groups_rounded,
                  color: Color(0xFF34A853),
                  size: 16,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  event.organizer,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildInfoRow(
            Icons.calendar_month_rounded,
            _formatDate(event.date),
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            Icons.access_time_rounded,
            event.time,
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            Icons.location_on_rounded,
            event.location,
          ),

          if (showStatus) ...[
            const SizedBox(height: 18),
            _buildStatusChip(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: event.status == "Open"
              ? const Color(0xFFE8F5E9)
              : Colors.orange.shade100,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          event.status,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: event.status == "Open"
                ? const Color(0xFF34A853)
                : Colors.orange.shade800,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF34A853),
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}

  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24),
      ),
      child: Stack(
        children: [
          Image.asset(
            event.imageUrl,
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF34A853),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                event.category,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}