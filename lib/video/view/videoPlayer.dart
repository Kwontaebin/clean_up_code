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
  double _sliderValue = 0.0;
  double _videoDuration = 0.0;  // 초기값을 0으로 설정

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('asset/video/mov_bbb.mp4') // 로컬 비디오 파일
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // 자동 재생
          _videoDuration = _controller.value.duration.inSeconds.toDouble(); // 비디오 길이 설정
        });
      });

    // 비디오 플레이어 상태 업데이트 리스너 추가
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        setState(() {
          _sliderValue = _controller.value.position.inSeconds.toDouble(); // 슬라이더 값 업데이트
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});  // 리스너 제거
    _controller.dispose();
    super.dispose();
  }

  void _rewind10Seconds() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 5);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
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

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
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
            else const Center(child: CircularProgressIndicator()),
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
            // 영상 길이 및 슬라이더 표시
            Positioned(
              bottom: 10,
              right: 20,
              left: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_controller.value.position), // 현재 위치
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatDuration(_controller.value.duration), // 총 길이
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: _videoDuration,
                    onChanged: (double value) {
                      setState(() {
                        _sliderValue = value;
                        _controller.seekTo(Duration(seconds: value.toInt()));
                      });
                    },
                    onChangeEnd: (double value) {
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
