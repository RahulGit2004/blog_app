import 'package:blog_app/features/blog/domain/entity/blog.dart';


class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imgUrl,
    required super.topics,
    required super.updatedAt,
    super.userName,
  });


  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imgUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? userName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imgUrl: json['img_url'] ?? '',
      topics: List<String>.from(json['topics'] ?? []),
      updatedAt: json['updated_at'] == null ? DateTime.now() :  DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'img_url': imgUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }





}
