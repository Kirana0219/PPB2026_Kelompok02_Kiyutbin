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
    final profile = _map(json['profiles']);
    final category = _map(json['categories']);

    return BlogModel(
      id: _string(json['id']),
      userId: _string(json['user_id']),
      categoryId: _string(json['category_id']),
      title: _string(json['title']),
      shortDescription: _string(json['short_description']),
      content: _string(json['content']),
      thumbnailUrl: _string(json['thumbnail_url']),
      readTime: _int(json['read_time']),
      isTrending: json['is_trending'] == true,
      publishedAt: _date(json['published_at']),
      createdAt: _date(json['created_at']),
      updatedAt: _date(json['updated_at']),
      authorName: _string(profile['full_name']),
      authorPhoto: profile['photo_url'] as String?,
      categoryName: _string(category['name']),
    );
  }

  static Map<String, dynamic> _map(dynamic value) =>
      value is Map ? Map<String, dynamic>.from(value) : const {};

  static String _string(dynamic value) => value?.toString() ?? '';

  static int _int(dynamic value) =>
      value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? 0;

  static DateTime _date(dynamic value) =>
      DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();

  BlogModel copyWith({
    String? categoryId,
    String? title,
    String? shortDescription,
    String? content,
    String? thumbnailUrl,
    int? readTime,
    bool? isTrending,
    DateTime? publishedAt,
    DateTime? updatedAt,
    String? categoryName,
  }) {
    return BlogModel(
      id: id,
      userId: userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      content: content ?? this.content,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      readTime: readTime ?? this.readTime,
      isTrending: isTrending ?? this.isTrending,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      authorName: authorName,
      authorPhoto: authorPhoto,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toInsertMap() => {
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

  Map<String, dynamic> toUpdateMap() => {
        'category_id': categoryId,
        'title': title,
        'short_description': shortDescription,
        'content': content,
        'thumbnail_url': thumbnailUrl,
        'read_time': readTime,
        'is_trending': isTrending,
        'updated_at': DateTime.now().toIso8601String(),
      };
}
