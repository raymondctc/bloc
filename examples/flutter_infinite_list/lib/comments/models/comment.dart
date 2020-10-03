import 'media.dart';
import 'user.dart';

class Comment {
  Comment({
    this.commentId,
    this.parent,
    this.text,
    this.timestamp,
    this.mentionMapping,
    this.type,
    this.threadId,
    this.permalink,
    this.level,
    this.isVoteMasked,
    this.mediaText,
    this.user,
    this.likeCount,
    this.dislikeCount,
    this.isPinned,
    this.childrenTotal,
    this.childrenUrl,
    this.media
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    List<Media> mediaList;
    if (json['media'] != null) {
      mediaList = <Media>[];
      var parsedMedia = json['media'] as List;
      for (var item in parsedMedia) {
        mediaList.add(Media.fromJson(item as Map<String, dynamic>));
      }
    }

    Map<String, String> mentionMapping;
    if (json['mentionMapping'] != null) {
      mentionMapping = {};
      var parsed = json['mentionMapping'] as Map<String, dynamic>;
      for (var key in parsed.keys) {
        mentionMapping[key] = parsed[key] as String;
      }
    }

    return Comment(
        commentId: json['commentId'] as String,
        parent: json['parent'] as String,
        text: json['text'] as String,
        timestamp: json['timestamp'] as int,
        mentionMapping: mentionMapping,
        type: json['type'] as String,
        threadId: json['threadId'] as String,
        permalink: json['permalink'] as String,
        level: json['level'] as int,
        isVoteMasked: json['isVoteMasked'] as int,
        mediaText: json['mediaText'] as String,
        user: json['user'] != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        likeCount: json['likeCount'] as int,
        dislikeCount: json['dislikeCount'] as int,
        isPinned: json['isPinned'] as int,
        childrenTotal: json['childrenTotal'] as int,
        childrenUrl: json['childrenUrl'] as String,
        media: mediaList
    );
  }

  final String commentId;
  final String parent;
  final String text;
  final int timestamp;
  final Map<String, String> mentionMapping;
  final String type;
  final String threadId;
  final String permalink;
  final int level;
  final int isVoteMasked;
  final String mediaText;
  final User user;
  final int likeCount;
  final int dislikeCount;
  final int isPinned;
  final int childrenTotal;
  final String childrenUrl;
  final List<Media> media;
}

class MentionMapping {
  MentionMapping({this.dummy});

  String dummy;
}