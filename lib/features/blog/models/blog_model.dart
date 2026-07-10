class BlogModel {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final String shortDescription;
  final String content;
  final String thumbnailUrl;
  final int readTime;
  final bool isTrending;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Relasi
  final String authorName;
  final String? authorPhoto;

  final String categoryName;

  const BlogModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.thumbnailUrl,
    required this.readTime,
    required this.isTrending,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.authorName,
    this.authorPhoto,
    required this.categoryName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      title: json['title'],
      shortDescription: json['short_description'],
      content: json['content'],
      thumbnailUrl: json['thumbnail_url'] ?? '',
      readTime: json['read_time'] ?? 0,
      isTrending: json['is_trending'] ?? false,
      publishedAt: DateTime.parse(json['published_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      authorName: json['profiles']['full_name'],
      authorPhoto: json['profiles']['photo_url'],
      categoryName: json['categories']['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'category_id': categoryId,
      'title': title,
      'short_description': shortDescription,
      'content': content,
      'thumbnail_url': thumbnailUrl,
      'read_time': readTime,
      'is_trending': isTrending,
      'published_at': publishedAt.toIso8601String(),
    };
  }
}