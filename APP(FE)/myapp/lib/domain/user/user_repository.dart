import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/join_request_dto.dart';
import 'package:myapp/controller/dto/login_request_dto.dart';
import 'package:myapp/domain/user/user.dart';
import 'package:myapp/domain/user/user_provider.dart';
import 'package:myapp/page_util/convert_utf8.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> login(String militaryNumber, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(militaryNumber, password);
    Response response = await _userProvider.login(loginReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    //서버 연결안되면 여기서 오류남. convertBody가 String이 되기 때문
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      User principal = User.fromJson(cmRespDto.data);
      // String token = headers["authorization"];
      return principal;
    } else {
      return User();
    }
  }

  Future<int> join(String name, String militaryNumber, String password,
      String rank, String unit, Map<String, String> allergy) async {
    JoinOrUpdateReqDto joinReqDto =
        JoinOrUpdateReqDto(name, militaryNumber, password, rank, unit, allergy);
    Response response = await _userProvider.join(joinReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    //서버 연결안되면 여기서 오류남. convertBody가 String이 되기 때문
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    return cmRespDto.code!;
  }

  Future<User> update(
      int id,
      String name,
      String militaryNumber,
      String password,
      String rank,
      String unit,
      Map<String, String> allergy) async {
    JoinOrUpdateReqDto joinReqDto =
        JoinOrUpdateReqDto(name, militaryNumber, password, rank, unit, allergy);
    Response response = await _userProvider.update(id, joinReqDto.toJson());
    dynamic headers = response.headers;
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    //서버 연결안되면 여기서 오류남. convertBody가 String이 되기 때문
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      User principal = User.fromJson(cmRespDto.data);
      // String token = headers["authorization"];
      return principal;
    } else {
      return User();
    }
  }
}
