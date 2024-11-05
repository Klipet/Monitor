import 'dart:io';

import 'package:logger/logger.dart';

class FileLogger {
  late Logger _logger;
  late File _logFile;

  FileLogger() {
    _initializeLogger();
  }

  Future<void> _initializeLogger() async {
    // Получаем путь к директории для хранения логов
    Directory? directory = await Directory.current;
    String logFilePath = '${directory.path}/app_log.txt';
    _logFile = File(logFilePath);

    // Инициализируем логгер
    _logger = Logger(
      printer: PrettyPrinter(), // Оформление вывода логов
      output: FileOutput(_logFile), // Вывод в файл
    );
  }

  void logInfo(String message) {
    _logger.i(message);
  }

  void logError(String message) {
    _logger.e(message);
  }

// Другие методы для логирования (warn, debug и т.д.)
}
class FileOutput extends LogOutput {
  final File logFile;

  FileOutput(this.logFile);

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      logFile.writeAsStringSync('${DateTime.now()}: $line\n',
          mode: FileMode.append);
    }
  }
}