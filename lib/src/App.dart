import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/pages/login_page.dart';
import 'package:huatang2/src/pages/tab_page.dart';


class App extends StatelessWidget {

  final UserInfoController _userInfoController = Get.put(UserInfoController());

  void printInfo(AsyncSnapshot snapshot) {

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if(snapshot.hasData) {
//            print('${snapshot.data.displayName}님 환영합니다');
//            printInfo(snapshot);
//            print(snapshot.data);
            _userInfoController.mappingUserInfo(snapshot);
//            return TabPage(snapshot.data);
            return TabPage();
          }
          return LoginPage();//Center(child: Text('login'));//
        }
      },
    );

  }
}
