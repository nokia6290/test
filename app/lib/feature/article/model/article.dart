import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.text,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        imageUrl: json['imageUrl'] as String? ?? '',
        text: json['text'] as String,
        createdAt: json['createdAt'] is DateTime
            ? json['createdAt'] as DateTime
            : (json['createdAt'] as Timestamp).toDate(),
      );

  factory Article.fromHackerNews(Map<String, dynamic> json) => Article(
        id: json['id'].toString(),
        title: 'Article from Hacker News',
        subtitle: json['title'] as String,
        text: json['url'] as String,
        imageUrl: '',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          json['time'] as int,
        ),
      );

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String text;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
        'text': text,
        'createdAt': createdAt,
      };
}
