import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/function/sizeFn.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('asset/video/mov_bbb.mp4') // 로컬 비디오 파일
          ..initialize().then((_) {
            _controller.play(); // 자동 재생
          },);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rewind10Seconds() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 5);
    _controller
        .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _fastForward10Seconds() {
    final currentPosition = _controller.value.position;
    final maxPosition = _controller.value.duration;
    final newPosition = currentPosition + const Duration(seconds: 5);
    _controller.seekTo(newPosition < maxPosition ? newPosition : maxPosition);
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Video Player",
        showLeading: false,
      ),
      body: SizedBox(
        height: deviceHeight(context) * 0.3,
        child: Stack(
          children: [
            if (_controller.value.isInitialized)
              GestureDetector(
                onDoubleTapDown: (details) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final touchX = details.localPosition.dx;

                  if (touchX < screenWidth / 2) {
                    _rewind10Seconds();
                  } else {
                    _fastForward10Seconds();
                  }
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
            Center(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
