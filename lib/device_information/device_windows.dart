import 'package:system_info2/system_info2.dart';
import 'package:network_info_plus/network_info_plus.dart';


class DeviceWindows{
  final String deviceID = SysInfo.kernelArchitecture.name;
  final String deviceModel = SysInfo.kernelArchitecture.name;
  final String deviceName = SysInfo.kernelName;
  final String osVersion = '${SysInfo.operatingSystemName} ${SysInfo.operatingSystemVersion}';
  final String serialNumber = SysInfo.kernelArchitecture.name;
}