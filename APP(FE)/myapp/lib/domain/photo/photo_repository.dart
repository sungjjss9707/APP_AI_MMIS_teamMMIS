import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/photo_upload_dto.dart';
import 'package:myapp/domain/photo/photo_provider.dart';
import 'package:myapp/page_util/convert_utf8.dart';

class PhotoRepository {
  final PhotoProvider _photoProvider = PhotoProvider();

  Future<int> upload(
      String photo, String content, String militaryNumber) async {
    PhotoUploadDto photoUploadDto =
        PhotoUploadDto(photo, content, militaryNumber);
    Response response = await _photoProvider.upload(photoUploadDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) return 1;
    return -1;
  }
}
