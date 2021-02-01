import 'dart:convert';
import 'package:flutter/cupertino.dart';

UserPhNoDm userPhNoDmFromJson(String str) => UserPhNoDm.fromJson(json.decode(str));

String userPhNoDmToJson(UserPhNoDm data) => json.encode(data.toJson());

class UserPhNoDm {
  UserPhNoDm({
    this.phoneNumber,
    this.countryCode,
  });

  String phoneNumber;
  String countryCode;

  factory UserPhNoDm.fromJson(Map<String, dynamic> json) => UserPhNoDm(
    phoneNumber: json["phoneNumber"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "countryCode": countryCode,
  };
}

SendOtpRespDm sendOtpRespDmFromJson(String str) => SendOtpRespDm.fromJson(json.decode(str));

String sendOtpRespDmToJson(SendOtpRespDm data) => json.encode(data.toJson());

class SendOtpRespDm {
  SendOtpRespDm({
    this.success,
    this.timestamp,
    this.data,
  });

  bool success;
  DateTime timestamp;
  OtpMessageData data;

  factory SendOtpRespDm.fromJson(Map<String, dynamic> json) => SendOtpRespDm(
    success: json["success"],
    timestamp: DateTime.parse(json["timestamp"]),
    data: OtpMessageData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "timestamp": timestamp.toIso8601String(),
    "data": data.toJson(),
  };
}

class OtpMessageData {
  OtpMessageData({
    this.message,
  });

  String message;

  factory OtpMessageData.fromJson(Map<String, dynamic> json) => OtpMessageData(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

LoginReqDm loginReqDmFromJson(String str) => LoginReqDm.fromJson(json.decode(str));

String loginReqDmToJson(LoginReqDm data) => json.encode(data.toJson());

class LoginReqDm {
  LoginReqDm({
    this.phoneNumber,
    this.countryCode,
    this.otp,
    this.deviceInfo,
  });

  String phoneNumber;
  String countryCode;
  String otp;
  DeviceInfo deviceInfo;

  factory LoginReqDm.fromJson(Map<String, dynamic> json) => LoginReqDm(
    phoneNumber: json["phoneNumber"],
    countryCode: json["countryCode"],
    otp: json["otp"],
    deviceInfo: DeviceInfo.fromJson(json["deviceInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "countryCode": countryCode,
    "otp": otp,
    "deviceInfo": deviceInfo.toJson(),
  };
}

class DeviceInfo {
  DeviceInfo({
    this.deviceId,
    this.osVersion,
    this.appVersion,
    this.platform,
    this.ip,
  });

  String deviceId;
  String osVersion;
  String appVersion;
  String platform;
  String ip;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    deviceId: json["deviceId"],
    osVersion: json["osVersion"],
    appVersion: json["appVersion"],
    platform: json["platform"],
    ip: json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "osVersion": osVersion,
    "appVersion": appVersion,
    "platform": platform,
    "ip": ip,
  };
}


LoginRespDm loginRespDmFromJson(String str) => LoginRespDm.fromJson(json.decode(str));

String loginRespDmToJson(LoginRespDm data) => json.encode(data.toJson());

class LoginRespDm {
  LoginRespDm({
    this.success,
    this.timestamp,
    this.data,
  });

  bool success;
  DateTime timestamp;
  AuthData data;

  factory LoginRespDm.fromJson(Map<String, dynamic> json) => LoginRespDm(
    success: json["success"],
    timestamp: DateTime.parse(json["timestamp"]),
    data: AuthData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "timestamp": timestamp.toIso8601String(),
    "data": data.toJson(),
  };
}

class AuthData {
  AuthData({
    this.authToken,
    this.refreshToken,
    this.user,
    this.isNewUser,
  });

  String authToken;
  String refreshToken;
  User user;
  bool isNewUser;

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    authToken: json["authToken"],
    refreshToken: json["refreshToken"],
    user: User.fromJson(json["user"]),
    isNewUser: json["isNewUser"],
  );

  Map<String, dynamic> toJson() => {
    "authToken": authToken,
    "refreshToken": refreshToken,
    "user": user.toJson(),
    "isNewUser": isNewUser,
  };
}

class User {
  User({
    this.id,
    this.countryCode,
    this.phoneNumber,
  });

  int id;
  String countryCode;
  String phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
  };
}



class LocationDm {
  double lat;
  double lng;
  String name;
  String address;
  IconData iconData;

  LocationDm(this.lat, this.lng, this.name, this.address, this.iconData);

}

ProductDm productDmFromJson(String str) => ProductDm.fromJson(json.decode(str));

String productDmToJson(ProductDm data) => json.encode(data.toJson());

class ProductDm {
  ProductDm({
    this.success,
    this.timestamp,
    this.data,
  });

  bool success;
  DateTime timestamp;
  ProductData data;

  factory ProductDm.fromJson(Map<String, dynamic> json) => ProductDm(
    success: json["success"],
    timestamp: DateTime.parse(json["timestamp"]),
    data: ProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "timestamp": timestamp.toIso8601String(),
    "data": data.toJson(),
  };
}

class ProductData {
  ProductData({
    this.products,
  });

  List<Product> products;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.maximumRetailPrice,
    this.maximumOrderQuantity,
    this.unit,
    this.productVariants,
    this.category,
    this.icon,
    this.image,
    this.isPrimary,
    this.isFavourite,
    this.promotions,
  });

  int id;
  String name;
  int maximumRetailPrice;
  dynamic maximumOrderQuantity;
  Unit unit;
  List<ProductVariant> productVariants;
  Category category;
  CustomIcon icon;
  CustomIcon image;
  bool isPrimary;
  bool isFavourite;
  List<String> promotions;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    maximumRetailPrice: json["maximumRetailPrice"],
    maximumOrderQuantity: json["maximumOrderQuantity"],
    unit: Unit.fromJson(json["unit"]),
    productVariants: List<ProductVariant>.from(json["productVariants"].map((x) => ProductVariant.fromJson(x))),
    category: Category.fromJson(json["category"]),
    icon: CustomIcon.fromJson(json["icon"]),
    image: CustomIcon.fromJson(json["image"]),
    isPrimary: json["isPrimary"],
    isFavourite: json["isFavourite"],
    promotions: List<String>.from(json["promotions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "maximumRetailPrice": maximumRetailPrice,
    "maximumOrderQuantity": maximumOrderQuantity,
    "unit": unit.toJson(),
    "productVariants": List<dynamic>.from(productVariants.map((x) => x.toJson())),
    "category": category.toJson(),
    "icon": icon.toJson(),
    "image": image.toJson(),
    "isPrimary": isPrimary,
    "isFavourite": isFavourite,
    "promotions": List<dynamic>.from(promotions.map((x) => x)),
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CustomIcon {
  CustomIcon({
    this.id,
    this.iconDefault,
    this.file,
  });

  int id;
  bool iconDefault;
  FileClass file;

  factory CustomIcon.fromJson(Map<String, dynamic> json) => CustomIcon(
    id: json["id"],
    iconDefault: json["default"],
    file: FileClass.fromJson(json["file"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "default": iconDefault,
    "file": file.toJson(),
  };
}

class FileClass {
  FileClass({
    this.id,
    this.filename,
    this.mimetype,
    this.previewUrl,
  });

  int id;
  String filename;
  String mimetype;
  String previewUrl;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    id: json["id"],
    filename: json["filename"],
    mimetype: json["mimetype"],
    previewUrl: json["previewUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "mimetype": mimetype,
    "previewUrl": previewUrl,
  };
}

class ProductVariant {
  ProductVariant({
    this.id,
    this.name,
    this.description,
    this.sku,
    this.maximumRetailPrice,
    this.unitValue,
    this.barcode,
  });

  int id;
  String name;
  String description;
  String sku;
  int maximumRetailPrice;
  int unitValue;
  dynamic barcode;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    sku: json["sku"],
    maximumRetailPrice: json["maximumRetailPrice"],
    unitValue: json["unitValue"],
    barcode: json["barcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "sku": sku,
    "maximumRetailPrice": maximumRetailPrice,
    "unitValue": unitValue,
    "barcode": barcode,
  };
}

class Unit {
  Unit({
    this.id,
    this.code,
    this.name,
  });

  int id;
  String code;
  String name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
