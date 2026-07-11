class PostModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final String seller;
  final String location;
  final int price;
  final String condition;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.seller,
    required this.location,
    required this.price,
    required this.condition,
    required this.createdAt,
  });
}
