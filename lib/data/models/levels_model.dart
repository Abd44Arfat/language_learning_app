class LevelResponse {
  final List<Level> data;
  final String message;
  final String status;

  LevelResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory LevelResponse.fromJson(Map<String, dynamic> json) {
    return LevelResponse(
      data: List<Level>.from(json['data'].map((x) => Level.fromJson(x))),
      message: json['message'],
      status: json['status'],
    );
  }
}

class Level {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String? imageUrl;

  Level({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
    );
  }
}
