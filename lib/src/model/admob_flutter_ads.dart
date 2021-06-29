import 'package:admob_flutter/admob_flutter.dart';

class AdMobManager {
  final bool _isTest = true;

//  /** Test IDs **/
  String testAppId = "ca-app-pub-3940256099942544~3347511713";
  String testAdUnitId = "ca-app-pub-3940256099942544/1033173712";

//  /** You real IDs **/, 앱이름 변경시, 다시 생성받아야 함.
  String realAppId = "ca-app-pub-6954011615087613~3268248245";
  String realAdUnitId = "ca-app-pub-6954011615087613/9259953280";

  static Admob initAdMob() {
    print("initAdMob");
    return Admob.initialize();
  }

  String getAppId() {
    return _isTest ? testAppId : realAppId;
  }

  String getAdUnitId() {
    return _isTest ? testAdUnitId : realAdUnitId;
  }

//  AdmobInterstitial createInterstitial(obj) { // 전면광고 testID(ca-app-pub-3940256099942544/1033173712)
//    String _getAdUnitId = getAdUnitId();
//
//    return AdmobInterstitial(adUnitId: _getAdUnitId,
//      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
//        if(event == AdmobAdEvent.loaded) {
//          print('****************************************_adUnitId(loaded): ' + _getAdUnitId.toString());
//          obj.show();
//        }
//        else if(event == AdmobAdEvent.closed) {
//          print('****************************************_adUnitId(closed): ' + _getAdUnitId.toString());
//          obj.dispose();
//        }
//      },
//    );
//  }

}