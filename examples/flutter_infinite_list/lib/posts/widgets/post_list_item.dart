import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/posts.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key key, @required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: [
          Text(post.title),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.network(post.imageUrl),
          )
        ],
      )
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
