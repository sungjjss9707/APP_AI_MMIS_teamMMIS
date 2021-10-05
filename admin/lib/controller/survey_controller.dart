import 'package:admin/domain/survey/survey.dart';

import 'package:get/get.dart';

class SurveyController extends GetxController {
  final surveys = <Survey>[].obs;
  final notice = Survey().obs;

  @override
  void onInit() {
    super.onInit();
  }
}
