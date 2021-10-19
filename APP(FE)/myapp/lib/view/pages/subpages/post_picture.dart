import 'dart:io' as Io;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/controller/photo_controller.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/view/components/button/back_button.dart';
import 'package:myapp/view/components/button/custom_upload_button.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostPicture extends StatefulWidget {
  @override
  _PostPictureState createState() => _PostPictureState();
}

class _PostPictureState extends State<PostPicture> {
  final ImagePicker _picker = ImagePicker();
  var image;
  final photo = Get.put(PhotoController());
  final user = Get.put(UserController());
  final _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("게시하기"),
      contentPadding: const EdgeInsets.all(16),
      children: [
        TextButton(
          onPressed: _getImageFromCamera,
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 10),
              Text(
                "카메라",
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: _getImageFromGallery,
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 10),
              Text(
                "갤러리에서 가져오기",
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        image != null ? Text(image.path) : Container(),
        CustomTextFormField(
          controller: _content,
          hint: "내용",
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Spacer(),
            CustomUploadButton(
                onPressed: () async {
                  final bytes = Io.File(image.path).readAsBytesSync();
                  String img64 = base64Encode(bytes);
                  await photo.upload(img64, _content.text,
                      user.principal.value.militaryNumber!);
                },
                text: "올리기"),
            SizedBox(width: 4.h),
            CustomBackButton(text: "취소"),
          ],
        )
      ],
    );
  }

  Future _getImageFromCamera() async {
    var _image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = _image;
    });
  }

  Future _getImageFromGallery() async {
    var _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
    });
  }
}
