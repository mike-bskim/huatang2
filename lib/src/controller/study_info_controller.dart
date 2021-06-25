import 'package:get/get.dart';

class StudyInfoController extends GetxController {
  static StudyInfoController get to => Get.find();

  // each chapter information, List()
  final RxList _chapterInfo = [].obs;

  List<dynamic> get chapterInfo => _chapterInfo;

  @override
  void onInit() {
    // TODO: implement onInit
    // 매 번경시마다 동작, 리엑티브 상태일때만 가능.
    ever(_chapterInfo, (_) => print(_chapterInfo.length));
    super.onInit();
  }
}