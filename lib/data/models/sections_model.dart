class Section {
  final int id;
  final String name;
  final String description;
  final String? image; // <- make image nullable
  final int levelId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Section({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.levelId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'], // image can now be null
      levelId: json['level_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}



class SectionsResponse {
  final List<Section> data;
  final String message;
  final String status;

  SectionsResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SectionsResponse.fromJson(Map<String, dynamic> json) {
    return SectionsResponse(
      data: List<Section>.from(json['data'].map((item) => Section.fromJson(item))),
      message: json['message'],
      status: json['status'],
    );
  }
}

