import 'dart:convert';
import 'dart:math';

class User {
  final int id;
  final String username;
  final String token;

  User(
    this.id,
    this.username,
    this.token,
  );

  User copyWith({
    int? id,
    String? username,
    String? token,
  }) {
    return User(
      id ?? this.id,
      username ?? this.username,
      token ?? this.token,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'],
      map['username'],
      map['token'],
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': username,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  String toString() => 'User(id: $id, username: $username, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode;
}
