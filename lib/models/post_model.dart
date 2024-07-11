import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String content;
  final String postImage;
  final String likes;
  final String comments;

  PostModel({
    required this.id,
    required this.content,
    this.postImage = '',
    this.likes = '0',
    this.comments = '0',
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      content: data['content'],
      postImage: data['postImage'] ?? '',
      likes: data['likes'] ?? '0',
      comments: data['comments'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'postImage': postImage,
      'likes': likes,
      'comments': comments,
    };
  }
}
