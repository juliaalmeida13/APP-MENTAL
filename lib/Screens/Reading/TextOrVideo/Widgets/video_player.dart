import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({required this.size, required this.videoUrl});

  final Size size;
  final String videoUrl;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      flags: YoutubePlayerFlags(
        startAt: 0,
        controlsVisibleAtStart: true,
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.9,
      height: 200,
      margin: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              width: widget.size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayer(
                controller: _youtubeController,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
