import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> likes; // User UIDs who liked the post
  final DateTime createdAt;

  // Getters to bridge old UI usage
  String get id => postId;
  String get authorName => 'User'; // Placeholder as we'll fetch user data 
  String? get authorPhotoUrl => null;

  PostModel({
    required this.postId,
    required this.userId,
    required this.title,
    required this.description,
    this.imageUrl,
    this.likes = const [],
    required this.createdAt,
  });

  factory PostModel.fromMap(Map<String, dynamic> map, String id) {
    return PostModel(
      postId: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      likes: List<String>.from(map['likes'] ?? []),
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'likes': likes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
