import 'package:get/get.dart';

const hostAI =
    "http://onlyshine-osamhack2021-app-ai-mmis-teammmis-q7vjwgw5wfwp4-5500.githubpreview.dev/";

class AIProvider extends GetConnect {
  Future<Response> getRecommendedMenus(Map data) {
    return post(
      "$hostAI",
      data,
    );
  }
}
