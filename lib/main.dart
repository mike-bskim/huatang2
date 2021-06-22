//import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:huatang2/src/App.dart';

//import 'admob_flutter_ads.dart';
/*     return Admob.initialize();
 */
Future<void> main() async {
//  AdMobManager.initAdMob();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // FutureBuilder 사용해서 선언위치 변경(app.dart)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: App(),
    );
  }
}