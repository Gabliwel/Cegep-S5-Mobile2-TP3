import 'dart:convert';

class Comment {
  final int id;
  final String body;
  final int userId;
  final String userName;
  

  Comment(
    this.id,
    this.body,
    this.userId,
    this.userName,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': userName,
      'text': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      map['id'],
      map['text'],
      map['user_id'],
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, user_id: $userId, name: $userName, text: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.userId == userId &&
        other.userName == userName &&
        other.body == body;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        body.hashCode;
  }
}
