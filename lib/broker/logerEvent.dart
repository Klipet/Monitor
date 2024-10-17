
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LogerEvent extends LogOutput {
  late final logFile;

  FileOutput() {
    _initLogFile();
  }

  Future<void> _initLogFile() async {
    final directory = await getApplicationDocumentsDirectory(); // Получаем директорию приложения
    final path = '${directory.path}/app_logs.txt'; // Путь к файлу логов
    logFile = File(path);
    await logFile.create(); // Создаем файл, если его нет

  }

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      logFile.writeAsStringSync('$line\n', mode: FileMode.append); // Записываем строки в файл
    }
  }
}
