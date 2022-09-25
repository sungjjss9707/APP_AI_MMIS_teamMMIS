import 'package:get/get.dart';

const hostAI = "http://15.164.129.36:5500";

class AIProvider extends GetConnect {
  Future<Response> getRecommendedMenus(Map data) {
    print(data);
    return post(
      "$hostAI",
      data,
    );
  }
}
