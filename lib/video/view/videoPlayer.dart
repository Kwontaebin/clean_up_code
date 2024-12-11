import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoRoute;

  const VideoPlayerScreen({
    super.key,
    required this.videoRoute,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double _sliderValue = 0.0;
  double _videoDuration = 0.0; // 초기값을 0으로 설정
  bool _isPlaying = false; // 비디오 재생 여부 상태값

  @override
  void initState() {
    super.initState();
    _controller =
    VideoPlayerController.asset(widget.videoRoute) // 로컬 비디오 파일
      ..initialize().then((_) {
        setState(() {
          // _controller.play(); // 자동 재생
          _videoDuration =
              _controller.value.duration.inSeconds.toDouble(); // 비디오 길이 설정
        });
      });
    // 비디오 플레이어 상태 업데이트 리스너 추가
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        setState(() {
          _sliderValue =
              _controller.value.position.inSeconds.toDouble(); // 슬라이더 값 업데이트
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {}); // 리스너 제거
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
      _isPlaying = !_isPlaying; // 상태 토글
      _isPlaying ? _controller.play() : _controller.pause();
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
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
            child: GestureDetector(
              onTap: _togglePlayPause, // 비디오 화면 클릭 시 재생/일시 정지 토글
              child: SizedBox(
                child: VideoPlayer(_controller),
              ),
            ),
          )
        else const Center(child: CircularProgressIndicator()),

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
    );
  }
}