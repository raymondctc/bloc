import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/comments/comments.dart';
import 'package:video_player/video_player.dart';

class CommentListItem extends StatefulWidget {
  const CommentListItem({
    Key key,
    @required this.comment,
    @required this.user
  }) : super(key: key);

  final Comment comment;
  final User user;

  @override
  _CommentListVideoItemState createState() => _CommentListVideoItemState();
}

class _CommentListVideoItemState extends State<CommentListItem> {
  VideoPlayerController videoPlayerController ;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.comment.media != null && widget.comment.media.first.imageMetaByType.video != null) {
      videoPlayerController = VideoPlayerController.network(widget.comment.media.first.imageMetaByType.video.url);
      _initializeVideoPlayerFuture = videoPlayerController.initialize()
          .then((value) => { setState(() {}) });
    }
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;
    final user = widget.user;
    final textTheme = Theme.of(context).textTheme;
    final boxWidth = MediaQuery.of(context).size.width * 0.7;

    Widget mediaContainer = const SizedBox.shrink();

    if (comment.media != null) {
      var firstMedia = comment.media.first;
      var type = comment.media.first.imageMetaByType.type;
      var hwRatio = firstMedia.sourceMeta.height /
          firstMedia.sourceMeta.width;
      var boundedHeight = hwRatio * boxWidth;
      // TODO: Constants
      switch (type) {
        case 'ANIMATED':
          if (firstMedia.imageMetaByType.video != null) {
            return FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatarUrl)
                          ),
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(Radius.circular(8))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                    user.displayName,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 0)
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: boxWidth
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                                  child: Text(
                                    comment.text,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: videoPlayerController.value.initialized
                                ? Container(
                                    width: boxWidth,
                                    height: boundedHeight,
                                    child: VideoPlayer(videoPlayerController)
                                ) : Container(),
                                onTap: () {
                                  setState(() {
                                    if (videoPlayerController.value.isPlaying) {
                                      videoPlayerController.pause();
                                    } else {
                                      videoPlayerController.play();
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: boxWidth,
                    height: boundedHeight
                  );
                }
              },
            );
          }
          break;
        case 'STATIC':
          if (firstMedia.imageMetaByType.image != null) {
            mediaContainer = Container(
              child: Image.network(
                  comment.media.first.imageMetaByType.image.getImageUrl()
              ),
              width: boxWidth,
              height: boundedHeight,
            );
          }
          break;
      }
    }




    var commentContainer = Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl)
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      user.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 0)
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: boxWidth
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                    child: Text(
                      comment.text,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                mediaContainer
              ],
            ),
          )
        ],
      ),
    );
    return commentContainer;

    // return ListTile(
    //   leading: Text('${post.id}', style: textTheme.caption),
    //   title: Text(post.title),
    //   isThreeLine: true,
    //   subtitle: Text(post.body),
    //   dense: true,
    // );
  }
}
