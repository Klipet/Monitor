import 'dart:io';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synchronized_keyboard_listener/synchronized_keyboard_listener.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSequence extends StatefulWidget {

  const VideoPlayerSequence({super.key});

  @override
  State<VideoPlayerSequence> createState() => _VideoPlayerSequenceState();
}

class _VideoPlayerSequenceState extends State<VideoPlayerSequence> {
  VideoPlayerController? _controller;
  List<File> _videoFiles = [];
  int _currentVideoIndex = 0;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadVideosFromFolder();
  }

  Future<void> _loadVideosFromFolder() async {
    final directory = Directory.current;
    // Путь к папке с видео
    final videDirectory = Directory('${directory.path}/video');
    final videoFiles = videDirectory.listSync().whereType<File>().toList();
    try{
      if (videoFiles.isNotEmpty) {
        _videoFiles = videoFiles;
        _initializeAndPlay(_currentVideoIndex);
      }
    }catch(e){
      isError = true;
    }
    print(directory);

  }

  void _initializeAndPlay(int index) {
    if (_controller != null) {
      _controller!.dispose();
    }
    _controller = VideoPlayerController.file(_videoFiles[index])
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
        _controller!.setLooping(false);
        _controller!.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller!.value.position == _controller!.value.duration) {
      _nextVideo();
    }
  }

  void _nextVideo() {
    _currentVideoIndex = (_currentVideoIndex + 1) % _videoFiles.length;
    _initializeAndPlay(_currentVideoIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not Found vodeo'),
                    ColorfulCircularProgressIndicator(
                      colors: [Colors.green,Colors.red,Colors.orange],
                              strokeWidth: 5,
                              indicatorHeight: 150,
                              indicatorWidth: 150,
                    ),
                  ],
                ),
              ],
            ),

      ),
    );
  }
}
