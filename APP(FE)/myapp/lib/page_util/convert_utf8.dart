import 'dart:convert';

dynamic convertUtf8ToObject(dynamic body) {
  String responseBody = jsonEncode(body); // json 데이터로 변경
  Map<String, dynamic> convertBody = jsonDecode(responseBody);
  return convertBody;
}
