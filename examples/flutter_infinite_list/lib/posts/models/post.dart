import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Post extends Equatable {
  const Post({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.imageUrl,
    this.videoUrl
  });

  final int id;
  final String title;
  final String body;
  final String imageUrl;
  final String videoUrl;

  @override
  List<Object> get props => [id, title, body, imageUrl, videoUrl];
}
