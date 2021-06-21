import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  void printInfo(AsyncSnapshot snapshot) {

    List<dynamic> aa = snapshot.data.metadata.toString().split(RegExp(r"[(,)]"));
    print(aa.toString());

    print(snapshot.data.displayName);
    print(snapshot.data.email);
    print(snapshot.data.metadata);
    print(snapshot.data.photoURL);
    print(snapshot.data.providerData);
    print(snapshot.data.providerData[0]);
    print(snapshot.data.refreshToken);
    print(snapshot.data.tenantId);
    print(snapshot.data.uid);
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
            print('${snapshot.data.displayName}님 환영합니다');
            printInfo(snapshot);
            return TabPage(snapshot.data);
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
