import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/comments/bloc/comment_bloc.dart';
import 'package:flutter_infinite_list/comments/comments.dart';
import 'package:flutter_infinite_list/comments/models/comment.dart';
import 'package:video_player/video_player.dart';

class CommentsList extends StatefulWidget {
  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final _scrollController = ScrollController();
  CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _commentBloc = context.bloc<CommentBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state.next != null && _isBottom) {
          _commentBloc.add(CommentFetched());
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CommentStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case CommentStatus.success:
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.comments.length
                      ? BottomLoader()
                      : CommentListItem(
                          comment: state.comments[index],
                          user: state.comments[index].user
                        );
                },
              itemCount: state.next == null
                  ? state.comments.length
                  : state.comments.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _commentBloc.add(CommentFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}