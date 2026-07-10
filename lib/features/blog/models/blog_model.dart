class BlogModel {
  final String id;
  final String title;
  final String shortDescription;
  final String content;
  final String thumbnailUrl;
  final int readTime;
  final DateTime publishedAt;
  final bool isTrending;
  final String category;
  final String author;
  final String authorPhoto;

  BlogModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.thumbnailUrl,
    required this.readTime,
    required this.publishedAt,
    required this.isTrending,
    required this.category,
    required this.author,
    required this.authorPhoto,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      shortDescription: json['short_description'] ?? '',
      content: json['content'],
      thumbnailUrl: json['thumbnail_url'] ?? '',
      readTime: json['read_time'] ?? 0,
      publishedAt: DateTime.parse(json['published_at']),
      isTrending: json['is_trending'] ?? false,
      category: json['categories']['name'],
      author: json['authors']['full_name'],
      authorPhoto: json['authors']['photo_url'] ?? '',
    );
  }
}