import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
  static UserInfoController get to => Get.find();

  final RxMap<String, String> _userInfo = {
    'displayName': '',
    'email': '',
    'photoURL': '',
    'uid': '',
    'providerId': '',
    's_uid': '',
    'userType': '',
    'userLangType': '',
  }.obs;

  void mappingUserInfo(AsyncSnapshot snapshot) {
    _userInfo['displayName'] = snapshot.data.displayName?? ' ';
    _userInfo['email'] = (snapshot.data.email)?? (snapshot.data.providerData[0].email);
    _userInfo['photoURL'] = (snapshot.data.photoURL)?? 'https://placeimg.com/200/200/nature';
    _userInfo['uid'] = (snapshot.data.uid);
    _userInfo['providerId'] = (snapshot.data.providerData[0].providerId);
    _userInfo['s_uid'] = (snapshot.data.providerData[0].uid);
  }

  Map<String, dynamic> get userInfo => _userInfo;

  void mappingUserType({required String userType, required String userLangType}) {
    _userInfo['userType'] = userType;
    _userInfo['userLangType'] = userLangType;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
//    ever((_userInfo) as RxInterface<dynamic>, (_) => print("매번 호출"));
    super.onInit();
  }
}