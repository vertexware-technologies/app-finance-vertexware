// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? token;
  int? role;
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
    this.role,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? token,
    int? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'role': role,
    };
  }

  static List<User> fromList(list) {
    return List<User>.from(list.map((x) => User.fromMap(x)));
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, token: $token, role: $role)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.token == token &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        role.hashCode;
  }
}
