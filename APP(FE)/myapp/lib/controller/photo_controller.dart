import 'package:get/get.dart';
import 'package:myapp/domain/photo/photo_repository.dart';

class PhotoController extends GetxController {
  final PhotoRepository _photoRepository = PhotoRepository();

  Future<void> upload(
      String photo, String content, String militaryNumber) async {
    int a = await _photoRepository.upload(photo, content, militaryNumber);
  }
}
