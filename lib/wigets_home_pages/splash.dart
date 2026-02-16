import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:monitor_for_sales/factory/post_get_url.dart';
import 'package:monitor_for_sales/factory/response_registr_app.dart';
import 'package:monitor_for_sales/wigets_home_pages/spash_license.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_andriod.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_windows.dart';
import 'package:system_info2/system_info2.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../broker/const.dart';
import '../broker/log.dart';
import '../factory/post_register_app.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../providers/setting_app.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  static const colorizeColors = [
    Colors.green,
    Colors.blue,
    Colors.white,
    Colors.red,
    Colors.orangeAccent
  ];
  static const colorizeTextStyle = TextStyle(
    fontSize: 90.0,
    fontFamily: 'RobotoBolt',
    fontWeight: FontWeight.bold
  );
  final fileLogger = FileLogger();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (){
      getUrl();
    });
    fileLogger.logInfo('startSpalsh');
    super.initState();
  }
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Monitor Asteptare',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
            isRepeatingAnimation: true,
            pause: const Duration(microseconds: 900),
        ),
      ),
    );
  }

  Future<void> getUrl() async {
    Constants constants = Constants();
    try{
  //  var pref = await SharedPreferences.getInstance();
    await SettingApp.init();
  //  pref.setDouble('ratio', MediaQuery.of(context).devicePixelRatio);

      const String applicationVersion = '1.0.0';
      final String deviceID = SysInfo.kernelArchitecture.name ;
      final String deviceModel = SysInfo.kernelArchitecture.name;
      final String deviceName = SysInfo.kernelName;
      final String osVersion = '${SysInfo.operatingSystemName} ${SysInfo.operatingSystemVersion}';
      final int osType = constants.WaiterAssistant;

      final info = NetworkInfo();
      final String privateIP = await info.getWifiIP() ?? info.getWifiGatewayIP().toString();
      final String publicIP = await getPublicIP();

      const String salePointAddress = '123 Main St';
      final String serialNumber = SysInfo.kernelArchitecture.name;
      const String workplace = 'Office';
      const String licenseActivationCode = '';
      final String? licenseID = await SettingApp.getLicenseID();//pref.getString('apiKey');

      // Создаем объект класса PostRegisterApp

      final deviceInfoToPost = PostGetUrl(
        applicationVersion: applicationVersion,
        deviceID: deviceID,
        deviceModel: deviceModel,
        deviceName: deviceName,
        licenseActivationCode: licenseActivationCode,
        osType: osType,
        osVersion: osVersion,
        privateIP: privateIP ?? 'Unknown',
        publicIP: publicIP,
        salePointAddress: salePointAddress,
        serialNumber: serialNumber,
        workplace: workplace,
        lastAuthorizedUser: '',
        licenseID: licenseID ?? '' ,
      );
    // Отправляем POST-запрос

      final url = Uri.parse('${constants.API_LICENSE}GetURI');
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('${constants.USERNAME}:${constants.PASSWORD}'))}';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(deviceInfoToPost.toJson()),
      );
      fileLogger.logInfo(response.body);
      if(response.statusCode == 200){
        fileLogger.logInfo(response.statusCode.toString());
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        final urlResponse = ResponseRegistrApp.fromJson(responseJson);
        if(urlResponse.errorCode == 0){
        //  pref.setString('uri', urlResponse.appData.uri);

          await SettingApp.setURI(urlResponse.appData.uri);
          if(Platform.isWindows){
            fileLogger.logInfo(response.statusCode.toString());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
            );
          }else if(Platform.isAndroid){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePagesAndroid()),
                  (Route<dynamic> route) => false,
            );
          }
        }else if(response.statusCode == 134){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const License()),
                (Route<dynamic> route) => false,
          );
        }
        else{
          fileLogger.logError('urlResponse.errorCode ${urlResponse.errorCode}');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const License()),
                (Route<dynamic> route) => false,
          );
        }
      }else if(response.statusCode == 502){
        if(Platform.isWindows){
          fileLogger.logError(response.body);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
          );
        }else if(Platform.isAndroid){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePagesAndroid()),
                (Route<dynamic> route) => false,
          );
        }
      }else if(response.statusCode == 404){
        if(Platform.isWindows){
          fileLogger.logError(response.body);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
          );
        }else if(Platform.isAndroid){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePagesAndroid()),
                (Route<dynamic> route) => false,
          );
        }
      } else if(response.statusCode == 400){
        if(Platform.isWindows){
          fileLogger.logError(response.body);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
          );
        }else if(Platform.isAndroid){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePagesAndroid()),
                (Route<dynamic> route) => false,
          );
        }
      }else{
        fileLogger.logError('error response.statusCode ${response.statusCode}');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const License()),
              (Route<dynamic> route) => false,
        );
      }

    }
    on HttpException{
      fileLogger.logError('error HttpException');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
      );
    }
    on IOException{
      fileLogger.logError('error IOException');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
      );
    }
    catch(e){
      fileLogger.logError('error Catch: ${e.toString()}');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const License()),
            (Route<dynamic> route) => false,
      );
    }

  }


  Future<String> getPublicIP() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['ip'];
      } else {
        throw Exception('Failed to get public IP');
      }
    } catch (e) {
      print('Error fetching public IP: $e');
      return 'Unknown';
    }
  }
}
