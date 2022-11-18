import 'dart:convert';

class Comment {
  final int userId;
  final int id;
  final String userName;
  final String body;

  Comment(
    this.userId,
    this.id,
    this.userName,
    this.body,
  );

  Comment copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return Comment(
      postId ?? this.userId,
      id ?? this.id,
      name ?? this.userName,
      body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': userId,
      'id': id,
      'name': userName,
      'body': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      map['postId'],
      map['id'],
      map['name'],
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(postId: $userId, id: $id, name: $userName, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.userId == userId &&
        other.id == id &&
        other.userName == userName &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        userName.hashCode ^
        body.hashCode;
  }
}
