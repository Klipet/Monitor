import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_windows.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_andriod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:permission_handler/permission_handler.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Установка полноэкранного режима
  if(Platform.isWindows){
    await WindowManager.instance.ensureInitialized();
    await WindowManager.instance.setFullScreen(true);
  }else if(Platform.isAndroid){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: SystemUiOverlay.values);
  }
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
        child: const MyApp(),
      ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    bool _platform = false;
    if (Platform.isAndroid){
      _platform = true;
    }else if(Platform.isWindows){
      _platform = false;
    }
    return OverlaySupport.global(
        child: MaterialApp(
      home: _platform
          ? HomePagesAndroid()
          : HomePage(),
        )
    );
  }
}
