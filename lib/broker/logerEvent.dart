import 'dart:async';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class FileOutput extends LogOutput {
  late final File file;

  FileOutput() {
    _init();
  }

  // Инициализация файла логов
  Future<void> _init() async {
    final directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/app_logs.txt');

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
  }

  // Переопределяем метод output
  @override
  void output(OutputEvent event) async {
    // Ждем завершения инициализации файла
    await _init();
    final logMessage = event.lines.join('\n');

    // Записываем логи в файл
    await file.writeAsString('$logMessage\n', mode: FileMode.append, flush: true);
  }
}