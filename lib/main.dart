import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:monitor_for_sales/adapter/my_sounds_model.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_box_right.dart';
import 'package:monitor_for_sales/providers/screen_setting_header.dart';
import 'package:monitor_for_sales/providers/screen_setting_left.dart';
import 'package:monitor_for_sales/providers/screen_setting_right.dart';
import 'package:monitor_for_sales/wigets_home_pages/splash.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_autostart/flutter_autostart.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'broker/log.dart';


//launch_at_startup 0.3.1

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fileLogger = FileLogger();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // Установка полноэкранного режима
  if (Platform.isWindows) {
    await WindowManager.instance.ensureInitialized();
    await WindowManager.instance.setFullScreen(true);
    await WindowManager.instance.setAlwaysOnTop(true);
    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
      packageName: 'com.example.monitor_for_sales',
    );
    await launchAtStartup.enable();
  } else if (Platform.isAndroid) {
    checkIsAutoStartEnabled();
    requestWifiPermission();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky, overlays: SystemUiOverlay.values);
  }
  await Hive.initFlutter();
  await Hive.openBox('settings');
  Hive.registerAdapter(MySoundModelAdapter());
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  print('Hive is initialized at: ${appDocumentDirectory.path}');
  fileLogger.logInfo("Приложение запущено");
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

Future<void> checkIsAutoStartEnabled() async {
  final _flutterAutostartPlugin = FlutterAutostart();
  String isAutoStartEnabled;
  try {
    isAutoStartEnabled =
    await _flutterAutostartPlugin.checkIsAutoStartEnabled() == true
        ? "Yes"
        : "No";
    print("isAutoStartEnabled: $isAutoStartEnabled");
    if (isAutoStartEnabled == 'No') {
      openAutoStartPermissionSettings();
    }
  } on PlatformException {
    isAutoStartEnabled = 'Failed to check isAutoStartEnabled.';
  }
}

Future<void> openAutoStartPermissionSettings() async {
  final _flutterAutostartPlugin = FlutterAutostart();
  String autoStartPermission;
  try {
    autoStartPermission =
        await _flutterAutostartPlugin.showAutoStartPermissionSettings() ??
            'Unknown autoStartPermission';
  } on PlatformException {
    autoStartPermission = 'Failed to show autoStartPermission.';
  }
}

void requestWifiPermission() async {
  var status = await Permission.locationWhenInUse.status;
  var locale = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.locationWhenInUse.request();
  }
  if (!locale.isGranted) {
    await Permission.location.request();
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return const OverlaySupport.global(
        child: MaterialApp(
          home: Splash()
        )
    );
  }



}


