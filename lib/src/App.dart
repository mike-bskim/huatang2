import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/pages/login_page.dart';
import 'package:huatang2/src/pages/tab_page.dart';

/*
User(
displayName: MIKE BS KIM,
email: michael.aeon@gmail.com,
emailVerified: true,
isAnonymous: false,
metadata: UserMetadata(
  creationTime: 2021-06-21 12:33:00.545,
  lastSignInTime: 2021-06-21 12:33:00.546),
phoneNumber: ,
photoURL: https://lh3.googleusercontent.com/a-/AOh14GiPpYLucVLYVTUmefIvyO4HS9bxV4dYPwMjxllIIg=s96-c,
providerData,
[UserInfo(displayName: MIKE BS KIM, email: michael.aeon@gmail.com, phoneNumber: , photoURL: https://lh3.googleusercontent.com/a-/AOh14GiPpYLucVLYVTUmefIvyO4HS9bxV4dYPwMjxllIIg=s96-c, providerId: google.com, uid: 115231844533834227546)],
refreshToken: ,
tenantId: null,
uid: f1yzWCqGSSgiXoE3hFxapufUjD23)
*/

class App extends StatelessWidget {

  final UserInfoController _userInfoController = Get.put(UserInfoController());

  void printInfo(AsyncSnapshot snapshot) {

    List<dynamic> aa = snapshot.data.metadata.toString().split(RegExp(r"[(,)]"));
    print(aa.toString());

//    print('displayName: ' + snapshot.data.displayName.toString());
//    print('email: ' + snapshot.data.email.toString());
    print('metadata: ' + snapshot.data.metadata.toString());
    print('metadata: ' + snapshot.data.metadata.lastSignInTime.toString());
//    print('photoURL: ' + snapshot.data.photoURL.toString());
//    print('providerData: ' + snapshot.data.providerData.toString());
//    print('providerData[0]: ' + snapshot.data.providerData[0].toString());
//    print('refreshToken: ' + snapshot.data.refreshToken.toString());
//    print('tenantId: ' + snapshot.data.tenantId.toString());
//    print('uid: ' + snapshot.data.uid.toString());
  }

//  void mappingUserInfo(AsyncSnapshot snapshot) {
//    _userInfoController.displayName(snapshot.data.displayName);
//    _userInfoController.email(snapshot.data.email);
//    _userInfoController.photoURL(snapshot.data.photoURL);
//    _userInfoController.uid(snapshot.data.uid);
//  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if(snapshot.hasData) {
            print('${snapshot.data.displayName}님 환영합니다');
//            printInfo(snapshot);
            _userInfoController.mappingUserInfo(snapshot);
            return TabPage(snapshot.data);
//            return TabPage();
          }
          return LoginPage();//Center(child: Text('login'));//
        }
      },
    );

//    return FutureBuilder(
//      future: Firebase.initializeApp(),
//      builder: (context, snapshot) {
//        if(snapshot.connectionState == ConnectionState.waiting) {
//          return Center(child: CircularProgressIndicator());
//        } else {
//          if(snapshot.hasData) {
//            return TabPage(snapshot.data);
//          }
//          return Center(
//            child: Text('login'),
//          );
//        }
//      }
//    );
  }
}
