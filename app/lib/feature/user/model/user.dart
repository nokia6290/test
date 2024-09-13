import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? '',
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );

  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime createdAt;
}
