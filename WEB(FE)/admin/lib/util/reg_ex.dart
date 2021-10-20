RegExp _isMilitaryNumber =
    RegExp(r"[0-9]{2}-[0-9]{8}|[0-9]{2}-[0-9]{5}|[0-9]{2}-[0-9]{6}");

bool isMilitaryNumber(String str) {
  var a = _isMilitaryNumber.firstMatch(str);
  if (a == null) return false;
  return true;
}
