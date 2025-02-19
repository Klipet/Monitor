import 'dart:io';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_view/gif_view.dart';
import 'package:monitor_for_sales/screens/settings_home_page.dart';
import 'package:synchronized_keyboard_listener/synchronized_keyboard_listener.dart';
import 'package:video_player/video_player.dart';

import '../providers/screen_setting_box_left.dart';

class VideoPlayerSequence extends StatefulWidget {
  const VideoPlayerSequence({super.key});

  @override
  State<VideoPlayerSequence> createState() => _VideoPlayerSequenceState();
}

class _VideoPlayerSequenceState extends State<VideoPlayerSequence> {
  VideoPlayerController? _controller;
  List<File> _videoFiles = [];
  List<File> _adVideos = []; // Пути к рекламным видео в assets
  int _currentIndex = 0; // Индекс текущего видео
  int _currentVideoIndex = 0; // Индекс текущего основного видео
  final int adIndex =
      0; // Индекс рекламы (предполагаем, что у нас одно рекламное видео)
  bool isError = false;
  late FocusNode _focusNode;
  GifController controller = GifController();

  @override
  void initState() {
    super.initState();
    _loadVideosFromFolder();
    _loadAdVideos();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

  }

  Future<void> _loadVideosFromFolder() async {
    final directory = Directory.current;
    // Путь к папке с видео
    final videDirectory = Directory('${directory.path}/video');
    final videoFiles = videDirectory.listSync().whereType<File>().toList();
    try {
      if (videoFiles.isNotEmpty) {
        _videoFiles = videoFiles;
        _initializeAndPlay(_currentIndex);
      }
    } catch (e) {
      isError = true;
    }
    print(directory);
  }

  Future<void> _loadAdVideos() async {
    // Загружаем рекламные видео из локальной файловой системы
    _adVideos.addAll([
      File('${Directory.current.path}/data/flutter_assets/assets/video/final.mp4'),
      // Путь к рекламному видео

    ]);
  }

  Future<void> _initializeAndPlay(int index) async {
    if (_controller != null) {
      await _controller!.dispose(); // Уничтожаем предыдущий контроллер
    }

    if (index < _videoFiles.length) {
      // Воспроизводим основное видео
      _controller = VideoPlayerController.file(_videoFiles[index])
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
          _controller!.setLooping(false);
          _controller!.addListener(() {
            if (_controller!.value.position == _controller!.value.duration) {
              // Если основное видео закончилось, воспроизводим рекламу
              _initializeAndPlayAd();
            }
          });
        });
    }
  }

  Future<void> _initializeAndPlayAd() async {
    if (_controller != null) {
      await _controller!.dispose(); // Уничтожаем предыдущий контроллер
    }

    // Воспроизводим рекламное видео
    _controller = VideoPlayerController.file(_adVideos[adIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
        _controller!.setLooping(false);
        _controller!.addListener(() {
          if (_controller!.value.position == _controller!.value.duration) {
            // Если реклама закончилась, переходим к следующему основному видео
            _currentVideoIndex++;
            if (_currentVideoIndex < _videoFiles.length) {
              // Если есть следующее основное видео
              _initializeAndPlay(_currentVideoIndex);
            } else {
              // Если все видео просмотрены, сбрасываем индекс и начинаем заново
              _currentVideoIndex = 0;
              _initializeAndPlay(_currentVideoIndex);
            }
          }
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SynchronizedKeyboardListener(keyEvents: <LogicalKeyboardKey, Function()>{
            LogicalKeyboardKey.escape: () {
              _handleEscapeKey();
            },
            LogicalKeyboardKey.f10: () {
              _handleF10Key();
            },
          },
              child:
        Center(
        child: _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not found video',
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                      SizedBox(
                          height: 40), // Отступ между текстом и индикатором
                      ColorfulCircularProgressIndicator(
                        colors: [Colors.green, Colors.red, Colors.orange],
                        strokeWidth: 5,
                        indicatorHeight: 150,
                        indicatorWidth: 150,
                      ),
                    ],
                  ),
                ),
        ),
              )
        )
        ]);
  }
  void _handleEscapeKey() {
    print('Escape pressed');
    // Закрыть приложение
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      exit(0);
    }
  }

  void _handleF10Key() {
    print('F10 pressed');
    // Открыть диалог настроек
    _showSettingsDialog(context);
  }
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: const SettingsDialogContent(),
          actions: <Widget>[
            //  Container(
            //    width: 150,
            //    height: 50,
            //    decoration: BoxDecoration(
            //      borderRadius: BorderRadius.circular(15),
            //    ),
            //    child: TextButton(
            //      child: Text('Cancel'),
            //      onPressed: () {
            //        Navigator.of(context).pop();
            //      },
            //    ),
            //  ),
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                child: Text('Save'),
                onPressed: () {
                  // Добавьте код для сохранения настроек
                  Navigator.of(context).pop();
                  //  boxLeft.saveSetings();
                  //  boxRight.saveBoxRight();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
