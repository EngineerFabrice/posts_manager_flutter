class Post {
  final int? id;
  final String title;
  final String body;
  final int? userId;

  Post({
    this.id,
    required this.title,
    required this.body,
    this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId ?? 1,
    };
  }

  Post copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }
}
