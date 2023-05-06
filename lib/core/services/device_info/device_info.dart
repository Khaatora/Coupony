

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract class IDeviceInfo{
  Future<String> get aDeviceInfo;
  Future<String> get iDeviceInfo;
  Future<String> get deviceInfo;
}

class DIPDeviceInfo implements IDeviceInfo{
  final DeviceInfoPlugin deviceInfoPlugin;


  DIPDeviceInfo(this.deviceInfoPlugin);

  @override
  Future<String> get aDeviceInfo async{
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.model;
  }

  @override
  Future<String> get iDeviceInfo async {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    return iosInfo.utsname.machine ?? iosInfo.model ?? "unknown";
  }
  @override
  Future<String> get deviceInfo async {
    if(Platform.isAndroid){ // android
      return aDeviceInfo;
    }else{ //ios, may need modification later
      return iDeviceInfo;
    }
  }
}

