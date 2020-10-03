import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/comments/comments.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key key,
    @required this.comment,
    @required this.user
  }) : super(key: key);

  final Comment comment;
  final User user;

  @override
  Widget build(BuildContext context) {
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
