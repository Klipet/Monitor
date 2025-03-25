import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class FileLogger {
  late Logger _logger;
  late File _logFile;

  static final FileLogger _instance = FileLogger._internal();

  factory FileLogger() => _instance;

  FileLogger._internal();

  Future<void> init() async {
    final exeDirectory = Platform.resolvedExecutable;
    final exeDir = File(exeDirectory).parent.path;
    final logFilePath = '$exeDir/app_log.txt';

    _logFile = File(logFilePath);
    await _createFileIfNotExists(_logFile);

    _logger = Logger(
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 6,
        lineLength: 120,
        colors: false,
        printEmojis: false,
        printTime: true,
      ),
      output: FileOutput(_logFile),
    );

    _logger.i('Logger initialized! Logs will be saved to: $logFilePath');
  }

  void logInfo(String message) {
    _logger.i(message);
  }

  void logError(String message) {
    _logger.e(message);
  }

  Future<void> _createFileIfNotExists(File file) async {
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
  }
}

class FileOutput extends LogOutput {
  final File logFile;

  FileOutput(this.logFile);

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      logFile.writeAsStringSync('${DateTime.now()}: $line\n', mode: FileMode.append);
    }
  }
}