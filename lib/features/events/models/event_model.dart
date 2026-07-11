class EventModel {
  final String id;
  final String title;
  final String organizer;
  final String category;
  final String imageUrl;
  final DateTime date;
  final String time;
  final String location;
  final String description;
  final String status;
  final List<String> highlights;
  final String phone;
  final String instagram;
  final String tiktok;

  const EventModel({
    required this.id,
    required this.title,
    required this.organizer,
    required this.category,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.status,
    required this.highlights,
    required this.phone,
    required this.instagram,
    required this.tiktok,
  });
}