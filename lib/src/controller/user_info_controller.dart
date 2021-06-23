import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
//  static UserInfoController get to => Get.find();
  final Map<String, dynamic> _userInfo = {
    'displayName': '',
    'email': '',
    'photoURL': '',
    'uid': '',
    'userType': '',
    'userLangType': '',
  };

  void mappingUserInfo(AsyncSnapshot snapshot) {
    _userInfo['displayName'] = (snapshot.data.displayName);
    _userInfo['email'] = (snapshot.data.email);
    _userInfo['photoURL'] = (snapshot.data.photoURL);
    _userInfo['uid'] = (snapshot.data.uid);
  }

  Map<String, dynamic> get userInfo => _userInfo;

  void mappingUserType({required String userType, required String userLangType}) {
    _userInfo['userType'] = userType;
    _userInfo['userLangType'] = userLangType;
  }

  void displayName(String str) {
    _userInfo['displayName'] = (str);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
//    ever((_userInfo) as RxInterface<dynamic>, (_) => print("매번 호출"));
    super.onInit();
  }
}

//class UserInfoController extends GetxController {
//  static UserInfoController get to => Get.find();
//  RxString _displayName = '' as RxString;
//  RxString _email = '' as RxString;
//  RxString _photoURL = '' as RxString;
//  RxString _uid = '' as RxString;
//
//  RxString _userType = '' as RxString;
//  RxString _userLangType = '' as RxString;
//
//  void displayName(String str) => _displayName(str);
//  void email(String str) => _email(str);
//  void photoURL(String str) => _photoURL(str);
//  void uid(String str) => _uid(str);
//  void userType(String str) => _userType(str);
//  void userLangType(String str) => _userLangType(str);
//
//
//
//  @override
//  void onInit() {
//    // TODO: implement onInit
//    super.onInit();
//  }
//}
