import 'package:get/get.dart';

class SelectExampleController extends GetxController {
  static SelectExampleController get to => Get.find();

  final RxBool checkValue1 = false.obs;
  final RxBool checkValue2 = false.obs;
  final RxBool checkValue3 = false.obs;
  final RxBool checkValue4 = false.obs;
  final RxInt teacherAnswer = 0.obs;

  final RxBool iconFlag = true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
//    ever(_chapterInfo, (_) => print(_chapterInfo.length));
    super.onInit();
  }

  void setIconFlag(bool flag) {
    iconFlag(flag);
  }

//  bool get iconFlag => iconFlag as bool;

  void setCheckBox(int index) {
    if (index == 1) {
      checkValue1(true);
      checkValue2(false);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(1);
    } else if (index == 2) {
      checkValue1(false);
      checkValue2(true);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(2);
    } else if (index == 3) {
      checkValue1(false);
      checkValue2(false);
      checkValue3(true);
      checkValue4(false);
      teacherAnswer(3);
    } else if (index == 4) {
      checkValue1(false);
      checkValue2(false);
      checkValue3(false);
      checkValue4(true);
      teacherAnswer(4);
    } else {
      checkValue1(false);
      checkValue2(false);
      checkValue3(false);
      checkValue4(false);
      teacherAnswer(0);
    }

  }
}

