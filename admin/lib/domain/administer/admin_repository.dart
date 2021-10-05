import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/login_request_dto.dart';
import 'package:admin/domain/administer/admin.dart';
import 'package:admin/domain/administer/admin_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:admin/util/jwtToken.dart';
import 'package:get/get.dart';

class AdministerRepository {
  final AdministerProvider _administerProvider = AdministerProvider();

  Future<Administer> login(String militaryNumber, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(militaryNumber, password);
    Response response = await _administerProvider.login(loginReqDto.toJson());
    dynamic headers = response.headers;
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Administer principal = Administer.fromJson(cmRespDto.data);
      String token = headers["authorization"];
      jwtToken = token;
      return principal;
    } else {
      return Administer();
    }
  }
}
