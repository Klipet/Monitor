import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:monitor_for_sales/broker/log.dart';
import 'package:monitor_for_sales/factory/post_register_app.dart';
import 'package:monitor_for_sales/factory/response_registr_app.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_andriod.dart';
import 'package:monitor_for_sales/wigets_home_pages/widget_windows.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_info2/system_info2.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numpad/numpad.dart';
import '../broker/const.dart';


class License extends StatefulWidget {
  const License({super.key});

  @override
  State<StatefulWidget> createState() => _License();
}

class _License extends State<License> {
  bool forceError = false;



  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(3),
      ));
  final putTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        //      color: questionsGroupColor,
        borderRadius: BorderRadius.circular(3),
      ));


  void putLicenseID(String license, String deviceName) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('licenseID', license);
    pref.setString('deviceID', deviceName);
    String? savedLicense = await pref.getString('licenseID');
    if (savedLicense != null) {
      // Лицензия сохранена
      print('Лицензия сохранена: $savedLicense');
    } else {
      // Лицензия не сохранена
      print('Лицензия не сохранена');
    }

  }
  @override
  void initState() {
    super.initState();
    openOnScreenKeyboard();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void openOnScreenKeyboard() async {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //const SizedBox(height: 64),
                    const Text(
                      'Введите код лицензий',
                      style: TextStyle(
                        fontFamily: 'RobotoBlack',
                        fontSize: 48,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Код лицензий состоит из 8 цифр',
                      style: TextStyle(
                        fontFamily: 'RobotoRegular',
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Pinput(
                        closeKeyboardWhenCompleted: true,
                        keyboardAppearance: Brightness.dark,
                        autofocus: true,
                        length: 8,
                        defaultPinTheme: defaultPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: false,
                        onCompleted: (code) {
                          NumPad(
                            onTap: (val) {
                              if (val == 99) {
                                if (code.isNotEmpty) {
                                  setState(() {
                                    code = code.substring(0, code.length - 1);
                                  });
                                }
                              } else {
                                setState(() {
                                  code += "$val";
                                });
                              }
                              print(code);
                            },
                          );
                          sendDeviceInfo(code);
                        },
                        forceErrorState: forceError,
                        submittedPinTheme: putTheme
                    ),
                    const SizedBox(height: 64),
                    forceError ? const Text(
                        'Неверный код лицензий',
                        style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          fontSize: 48,
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                        )
                    ) : Container(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendDeviceInfo(String licenseCode) async {
    Constants constants = Constants();
    var pref = await SharedPreferences.getInstance();
    // Получаем информацию об устройстве
    final String applicationVersion = '1.0.0';
    final String deviceID = SysInfo.kernelArchitecture.name;
    final String deviceModel = SysInfo.kernelArchitecture.name;
    final String deviceName = SysInfo.kernelName;
    final String osVersion = '${SysInfo.operatingSystemName} ${SysInfo.operatingSystemVersion}';
    final int osType = constants.WaiterAssistant;

    final info = NetworkInfo();
    final String? privateIP = await info.getWifiIP();
    final String publicIP = await getPublicIP();

    final String salePointAddress = '123 Main St';
    final String serialNumber = SysInfo.kernelArchitecture.name;
    final String workplace = 'Office';
    final String licenseActivationCode = licenseCode;

    // Создаем объект класса PostRegisterApp
    final deviceInfo = PostRegisterApp(
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
    );

    try{
      final url = Uri.parse('${constants.API_LICENSE}RegisterApplication');
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('${constants.USERNAME}:${constants.PASSWORD}'))}';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(deviceInfo.toJson()),
      );
      if (response.statusCode == 200) {
        print('Data sent successfully');
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        final apiResponse = ResponseRegistrApp.fromJson(responseJson);
        pref.setString('apiKey', apiResponse.appData.licenseID);
        pref.setString('uri', apiResponse.appData.uri);
        if(Platform.isWindows){
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
      } else {
        print('Failed to send data: ${response.statusCode}');
        FileLogger().logError(response.body);
        setState(() {
          forceError = true;
        });
      }
    }catch(e){
      setState(() {
        print('Failed to send data: ${e.toString()}');
        FileLogger().logError(e.toString());
        forceError = true;
      });
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