import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:list/data_model/data_model.dart';
import 'package:list/data_repo/index.dart';
import 'package:list/network/network_interceptor.dart';
import 'package:package_info/package_info.dart';

class NetworkManager {

  HttpClientWithInterceptor getHttpClient() {
    return new HttpClientWithInterceptor.build(interceptors: [NetworkInterceptor(),]);
  }

  Future<SendOtpRespDm> sendOtp(String phoneNumber) async {
    String url = "$host" + "/api/users/send-otp";
    UserPhNoDm userPhNo = new UserPhNoDm();
    userPhNo.phoneNumber = phoneNumber;
    userPhNo.countryCode = "91";
    var resp = await getHttpClient().post(url, body: userPhNoDmToJson(userPhNo));
    try {
      SendOtpRespDm response = sendOtpRespDmFromJson(resp.body);
      return response;
    } catch (e) {
      return null;
    }
  }


  Future<LoginRespDm> verifyOtp(String phNo, String otp) async {

    DeviceInfo deviceData = new DeviceInfo();
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceData.deviceId = iosDeviceInfo.identifierForVendor;
      deviceData.platform = "IOS";
      deviceData.osVersion = "12.0";
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceData.deviceId =  androidDeviceInfo.androidId;
      deviceData.platform = "ANDROID";
      deviceData.osVersion = "12.0";
    }
    deviceData.ip = "127.0.0.1";
    final PackageInfo info = await PackageInfo.fromPlatform();
    deviceData.appVersion = info.version;

    String url = "$host" + "/api/users/sessions";
    LoginReqDm loginData = new LoginReqDm();
    loginData.phoneNumber = phNo;
    loginData.countryCode = "91";
    loginData.otp = otp;
    loginData.deviceInfo = deviceData;
    var resp = await getHttpClient().post(url, body: loginReqDmToJson(loginData));
    try {
      LoginRespDm response = loginRespDmFromJson(resp.body);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<bool> logout() async {
    String url = "$host" + "/api/users/sessions";
    var resp = await getHttpClient().delete(url);
    if(resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ProductDm> getProducts(double lat, double lng) async {
    String url = "$host" + "/api/products?lat=" + "$lat" + "&lng=" + "$lng";
    var resp = await getHttpClient().get(url);
    try {
      ProductDm response = productDmFromJson(resp.body);
      return response;
    } catch (e) {
      return null;
    }
  }

}