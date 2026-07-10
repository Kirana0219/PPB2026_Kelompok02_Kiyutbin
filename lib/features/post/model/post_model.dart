class PostModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['image_url'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}