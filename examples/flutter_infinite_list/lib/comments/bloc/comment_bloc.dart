import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/comments/models/comment.dart';
import 'package:flutter_infinite_list/comments/models/payload.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({@required this.httpClient}) : super(const CommentState());

  final http.Client httpClient;

  @override
  Stream<Transition<CommentEvent, CommentState>> transformEvents(
      Stream<CommentEvent> events,
      TransitionFunction<CommentEvent, CommentState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is CommentFetched) {
      yield await _mapCommentFetchedToState(state);
    }
  }

  Future<CommentState> _mapCommentFetchedToState(CommentState state) async {
    try {
      if (state.status == CommentStatus.initial) {
        final payload = await _fetchComments(
            'a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b',
            'http://9gag.com/gag/aEg6q8M',
            30, 'new', null, null
        );
        return state.copyWith(
            status: CommentStatus.success,
            comments: payload.comments,
            next: payload.next,
            prev: payload.prev,
            parent: payload.parent,
            lock: payload.lock,
            total: payload.total,
            level: payload.level
        );
      }
      final payload = await _fetchComments(
          'a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b',
          'https://9gag.com/gag/aEg6q8M',
          30, 'new', state.next, null
      );
      return state.copyWith(
          status: CommentStatus.success,
          comments: List.of(state.comments)..addAll(payload.comments),
          next: payload.next,
          prev: payload.prev,
          parent: payload.parent,
          lock: payload.lock,
          total: payload.total,
          level: payload.level
      );
    } on Exception {
      return state.copyWith(status: CommentStatus.failure);
    }
  }

  Future<Payload> _fetchComments(String appId,
      String url, int count, String type,
      String next, String prev) async {

    String api;

    if (next != null) {
      api = 'https://comment-cdn.9gag.com/v2/cacheable/comment-list.json?appId=$appId&count=$count&type=$type&url=${Uri.encodeFull(url)}&next=$next';
    } else if (prev != null) {
      api = 'https://comment-cdn.9gag.com/v2/cacheable/comment-list.json?appId=$appId&count=$count&type=$type&url=${Uri.encodeFull(url)}&prev=$prev';
    } else {
      api = 'https://comment-cdn.9gag.com/v2/cacheable/comment-list.json?appId=$appId&count=$count&type=$type&url=${Uri.encodeFull(url)}';
    }

    final response = await httpClient.get(api);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data['payload'] != null) {
        return Payload.fromJson(data['payload'] as Map<String, dynamic>);
      }
    }
    throw Exception('error fetching comments');
  }
}