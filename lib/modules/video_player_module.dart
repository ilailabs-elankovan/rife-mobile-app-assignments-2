import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerModule extends StatefulWidget {
  const VideoPlayerModule({super.key});

  @override
  State<VideoPlayerModule> createState() => _VideoPlayerModuleState();
}

class _VideoPlayerModuleState extends State<VideoPlayerModule> {

  late VideoPlayerController _controller;

  String videoUrlFirebase = 'https://firebasestorage.googleapis.com/v0/b/rife-mobile-app.appspot.com/o/RifeMobileAppAssets%2Fonboarding_screen_video_2.mp4?alt=media&token=873790bd-2a23-4adf-a452-90b7893847e0';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        videoUrlFirebase))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );


  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
