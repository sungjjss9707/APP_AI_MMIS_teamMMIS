import 'package:get/get.dart';

class Survey {
  final RxString? title;
  final RxString? explain;
  final RxList<RxMap>? questions;

  Survey({this.title, this.explain, this.questions});
}
