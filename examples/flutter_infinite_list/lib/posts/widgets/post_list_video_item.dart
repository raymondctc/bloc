import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PostListVideoItem extends StatefulWidget {

  const PostListVideoItem({
    Key key,
    @required this.post,
    @required this.user
  }) : super(key: key);

  final Post post;
  final User user;

  @override
  _PostLisVideoItemState createState() => _PostLisVideoItemState();
}

class _PostLisVideoItemState extends State<PostListVideoItem> {
  VideoPlayerController videoPlayerController ;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.post.videoUrl);
    _initializeVideoPlayerFuture = videoPlayerController.initialize()
        .then((value) => { setState(() {}) });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                            widget.user.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 4, 4, 0)
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 300
                        ),
                        child: GestureDetector(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                              child: Center(
                                  child: videoPlayerController.value.initialized
                                      ? AspectRatio(
                                    aspectRatio: videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(videoPlayerController),
                                  )
                                      : Container()
                              )
                          ),
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
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}