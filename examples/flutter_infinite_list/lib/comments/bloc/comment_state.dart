part of 'comment_bloc.dart';

enum CommentStatus { initial, success, failure }

///
///
///
class CommentState extends Equatable {
  const CommentState({
    this.status = CommentStatus.initial,
    this.comments = const <Comment>[],
    this.next,
    this.prev,
    this.total = 0,
    this.lock = false,
    this.parent,
    this.level = 1
  });

  final CommentStatus status;
  final List<Comment> comments;
  final String next;
  final String prev;
  final int total;
  final bool lock;
  final Comment parent;
  final int level;

  CommentState copyWith({
    CommentStatus status,
    List<Comment> comments,
    String next,
    String prev,
    int total,
    bool lock,
    Comment parent,
    int level
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      next: next ?? this.next,
      prev: prev ?? this.prev,
      total: total ?? this.total,
      lock: lock ?? this.lock,
      parent: parent ?? this.parent
    );
  }

  @override
  List<Object> get props => [
    status, comments,
    next, prev, total,
    lock, parent, level
  ];


}