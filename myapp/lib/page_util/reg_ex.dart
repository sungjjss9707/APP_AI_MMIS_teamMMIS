// 장교 군번 판별
RegExp _isMilitaryNumber1 = RegExp(r"[0-9]{2}-[0-9]{5}");

// 부사관 군번 판별
RegExp _isMilitaryNumber2 = RegExp(r"[0-9]{2}-[0-9]{6}");

// 준사관 군번 판별
RegExp _isMilitaryNumber3 = RegExp(r"[0-9]{2}-[0-9]{8}");

bool isMilitaryNumber(String str) {
  if (str.length == 8) {
    var a = _isMilitaryNumber1.firstMatch(str);
    if (a != null) return true;
  } else if (str.length == 9) {
    var a = _isMilitaryNumber2.firstMatch(str);
    if (a != null) return true;
  } else if (str.length == 11) {
    var a = _isMilitaryNumber3.firstMatch(str);
    if (a != null) return true;
  }
  return false;
}
