import 'package:admin/util/reg_ex.dart';
import 'package:validators/validators.dart';

Function validateMilitaryNumber() {
  return (String? value) {
    if (value!.isEmpty) {
      return "군번를 기입하십시오.";
    } else if (!isMilitaryNumber(value)) {
      return "군번 형식이 잘못 되었습니다.";
    } else if (value.length > 20) {
      return "입력값이 너무 깁니다.";
    } else {
      return null;
    }
  };
}

Function validatePassWord() {
  return (String? value) {
    if (value!.isEmpty) {
      return "비밀번호를 기입하십시오.";
    } else if (!isAlphanumeric(value)) {
      return "비밀번호는 영문과 숫자만 가능합니다.";
    } else if (value.length > 15) {
      return "비밀번호는 15자 이하로 해주십시오.";
    } else if (value.length < 5) {
      return "비밀번호는 5자 이상으로 해주십시오.";
    } else {
      return null;
    }
  };
}

Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "Email을 기입하십시오.";
    } else if (!isEmail(value)) {
      return "이메일 형식이 아닙니다.";
    } else {
      return null;
    }
  };
}

Function validateTitle() {
  return (String? value) {
    if (value!.isEmpty) {
      return "제목을 입력해주세요.";
    } else if (value.length > 30) {
      return "제목이 너무 깁니다. 30자 이하로 쓰세요.";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length > 500) {
      return "글 분량을 초과했습니다. 500자 이하";
    } else {
      return null;
    }
  };
}

Function validateIsEmpty() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else {
      return null;
    }
  };
}
