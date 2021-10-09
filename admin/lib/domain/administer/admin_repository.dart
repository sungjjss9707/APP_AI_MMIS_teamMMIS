import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/join_request_dto.dart';
import 'package:admin/controller/dto/login_request_dto.dart';
import 'package:admin/domain/administer/admin.dart';
import 'package:admin/domain/administer/admin_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

class AdministerRepository {
  final AdministerProvider _administerProvider = AdministerProvider();

  Future<Administer> login(String militaryNumber, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(militaryNumber, password);
    Response response = await _administerProvider.login(loginReqDto.toJson());
    dynamic headers = response.headers;
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    //서버 연결안되면 여기서 오류남. convertBody가 String이 되기 때문
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Administer principal = Administer.fromJson(cmRespDto.data);
      // String token = headers["authorization"];
      return principal;
    } else {
      return Administer();
    }
  }

  Future<int> join(String name, String militaryNumber, String password,
      String rank, String unit) async {
    JoinReqDto joinReqDto =
        JoinReqDto(name, militaryNumber, password, rank, unit);
    Response response = await _administerProvider.join(joinReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    print(convertBody);
    //서버 연결안되면 여기서 오류남. convertBody가 String이 되기 때문
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    return cmRespDto.code!;
  }
}
