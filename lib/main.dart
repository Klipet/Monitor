import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:monitor_for_sales/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  // Установка полноэкранного режима
  await WindowManager.instance.setFullScreen(true);
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ScreenSettingsLeft()),
          ChangeNotifierProvider(create: (context) => ScreenSettingsRight()),
          ChangeNotifierProvider(create: (context) => ScreenSettingsHeader()),
          ChangeNotifierProvider(create: (context) => ScreenSettingsBoxLeft()),
          ChangeNotifierProvider(create: (context) => ScreenSettingsBoxRight()),
          // Добавьте другие провайдеры здесь
        ],
        child: MyApp(),
      ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
