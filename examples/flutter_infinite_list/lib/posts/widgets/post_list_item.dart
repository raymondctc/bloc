import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/posts.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key key,
    @required this.post,
    @required this.user
  }) : super(key: key);

  final Post post;
  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: [
          const Padding(
            child: CircleAvatar(
              child: Text('AH'),
              backgroundColor: Colors.grey,
            ),
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
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
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 0)
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                    child: Text(
                      post.title,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    // return ListTile(
    //   leading: Text('${post.id}', style: textTheme.caption),
    //   title: Text(post.title),
    //   isThreeLine: true,
    //   subtitle: Text(post.body),
    //   dense: true,
    // );
  }
}
