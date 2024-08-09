

class PostRegisterApp{

  late final String applicationVersion;
  late final String deviceID;
  late final String deviceModel;
  late final String deviceName;
  late final String licenseActivationCode;
  late final int osType;
  late final String osVersion;
  late final String privateIP;
  late final String publicIP;
  late final String salePointAddress;
  late final String serialNumber;
  late final String workplace;

  PostRegisterApp({
    required this.applicationVersion,
    required this.deviceID,
    required this.deviceModel,
    required this.deviceName,
    required this.licenseActivationCode,
    required this.osType,
    required this.osVersion,
    required this.privateIP,
    required this.publicIP,
    required this.salePointAddress,
    required this.serialNumber,
    required this.workplace,
  });
  Map<String, dynamic> toJson() {
    return {
      'ApplicationVersion': applicationVersion,
      'DeviceID': deviceID,
      'DeviceModel': deviceModel,
      'DeviceName': deviceName,
      'LicenseActivationCode': licenseActivationCode,
      'OSType': osType,
      'OSVersion': osVersion,
      'PrivateIP': privateIP,
      'PublicIP': publicIP,
      'SalePointAddress': salePointAddress,
      'SerialNumber': serialNumber,
      'Workplace': workplace,
    };
  }
}