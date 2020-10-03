import 'comment.dart';

class Payload {
  Payload({
    this.url,
    this.status,
    this.lock,
    this.total,
    this.opUserId,
    this.comments,
    this.prev,
    this.next,
    this.parent,
    this.level
  });

  // url = json['url'] as String;
  // status = json['status'];
  // lock = json['lock'];
  // total = json['total'];
  // opUserId = json['opUserId'];
  // if (json['comments'] != null) {
  // comments = new List<Comments>();
  // json['comments'].forEach((v) { comments.add(new Comments.fromJson(v)); });
  // }
  // prev = json['prev'];
  // next = json['next'];
  // parent = json['parent'];
  // level = json['level'];

  factory Payload.fromJson(Map<String, dynamic> json) {

    var comments = <Comment>[];

    var parsed = (json['comments'] as List);
    for (var item in parsed) {
      comments.add(Comment.fromJson(item as Map<String, dynamic>));
    }
    var parent = json['parent'] == null
        ? null
        : Comment.fromJson(json['parent'] as Map<String, dynamic>);

    return Payload(
      url: json['url'] as String,
      status: json['status'] as String,
      lock: json['lock'] as bool,
      total: json['total'] as int,
      opUserId: json['opUserId'] as String,
      prev: json['prev'] == null ? null : json['prev'] as String,
      next: json['next'] == null ? null : json['next'] as String,
      level: json['level'] as int,
      comments: comments,
      parent: parent
    );
  }

  final String url;
  final String status;
  final bool lock;
  final int total;
  final String opUserId;
  final List<Comment> comments;
  final String prev; // nullable
  final String next; // nullable
  final Comment parent; // nullable
  final int level;
}