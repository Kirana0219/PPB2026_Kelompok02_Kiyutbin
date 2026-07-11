import '../models/event_model.dart';

final List<EventModel> dummyEvents = [
  EventModel(
    id: '1',
    title: 'Beach Clean-Up Day',
    organizer: 'KiyutBin Community',
    category: 'Volunteer',
    imageUrl: 'assets/images/events/beach_cleanup.jpg',
    date: DateTime(2026, 7, 11),
    time: '08:00 - 11:30 WITA',
    location: 'Pantai Sanur, Denpasar',
    description:
        'Join us for a beach clean-up event to help keep our coastline clean while raising awareness about environmental sustainability.',
    status: 'Open',
    highlights: [
      'Trash bags provided',
      'Gloves provided',
      'Certificate of Participation',
      'Community Service Hours',
    ],
    phone: '+62 812-3456-7890',
    instagram: '@kiyutbin',
    tiktok: '@kiyutbin',
  ),

  EventModel(
    id: '2',
    title: 'Plastic Recycling Workshop',
    organizer: 'Green Earth Bali',
    category: 'Workshop',
    imageUrl: 'assets/images/events/recycle_workshop.jpg',
    date: DateTime(2026, 7, 23),
    time: '09:00 - 12:00 WITA',
    location: 'Renon, Denpasar',
    description:
        'Learn how to recycle plastic waste into useful household products through hands-on activities.',
    status: 'Open',
    highlights: [
      'Workshop Kit',
      'Snacks',
      'Certificate',
    ],
    phone: '+62 811-1111-1111',
    instagram: '@greenearthbali',
    tiktok: '@greenearthbali',
  ),

  EventModel(
    id: '3',
    title: 'Mangrove Planting',
    organizer: 'Bali Eco Community',
    category: 'Volunteer',
    imageUrl: 'assets/images/events/mangrove.jpg',
    date: DateTime(2026, 8, 2),
    time: '07:00 - 10:00 WITA',
    location: 'Mangrove Forest, Denpasar',
    description:
        'Help restore Bali’s mangrove ecosystem by participating in a mangrove planting activity.',
    status: 'Registered',
    highlights: [
      'Free T-shirt',
      'Lunch',
      'Certificate',
    ],
    phone: '+62 822-2222-2222',
    instagram: '@balieco',
    tiktok: '@balieco',
  ),

  EventModel(
    id: '4',
    title: 'Tree Planting',
    organizer: 'Bali Eco Community',
    category: 'Volunteer',
    imageUrl: 'assets/images/events/tree_planting.jpg',
    date: DateTime(2026, 8, 15),
    time: '06:00 - 09:00 WITA',
    location: 'Monkey Forest, Denpasar',
    description:
        'Help restore Bali’s ecosystem by participating in a tree planting activity.',
    status: 'Open',
    highlights: [
      'Free T-shirt',
      'Lunch',
      'Certificate',
    ],
    phone: '+62 822-2222-2222',
    instagram: '@balieco',
    tiktok: '@balieco',
  ),
];