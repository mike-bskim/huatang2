import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huatang2/src/controller/user_info_controller.dart';
import 'package:huatang2/src/pages/login_page.dart';
import 'package:huatang2/src/pages/tab_page.dart';


class App extends StatelessWidget {

  final UserInfoController _userInfoController = Get.put(UserInfoController());

//    print('metadata: ' + snapshot.data.metadata.toString());
//    print('metadata: ' + snapshot.data.metadata.lastSignInTime.toString());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if(snapshot.hasData) {
            _userInfoController.mappingUserInfo(snapshot);
//            print(snapshot.data);
//            print('providerData: ' + snapshot.data.providerData[0].email.toString());
            return TabPage();
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
