import 'package:get/get.dart';

class ChapterInfoController extends GetxController {
  static ChapterInfoController get to => Get.find();

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