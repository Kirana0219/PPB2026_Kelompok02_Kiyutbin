class AuthModel {
  final String id;
  final int? roleId;
  final String fullName;
  final String email;
  final String? phone;
  final String? photoUrl;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthModel({
    required this.id,
    this.roleId,
    required this.fullName,
    required this.email,
    this.phone,
    this.photoUrl,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      roleId: json['role_id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photo_url'],
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'photo_url': photoUrl,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  AuthModel copyWith({
    String? id,
    int? roleId,
    String? fullName,
    String? email,
    String? phone,
    String? photoUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthModel(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}