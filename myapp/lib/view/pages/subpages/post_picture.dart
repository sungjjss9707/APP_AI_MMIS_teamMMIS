import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/view/components/button/back_button.dart';
import 'package:myapp/view/components/button/custom_upload_button.dart';

class PostPicture extends StatefulWidget {
  @override
  _PostPictureState createState() => _PostPictureState();
}

class _PostPictureState extends State<PostPicture> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

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
        SizedBox(height: 4),
        image != null
            ? Image.file(
                File(image!.path),
                fit: BoxFit.contain,
              )
            : Container(),
        Row(
          children: [
            Spacer(),
            CustomUploadButom(
                onPressed: () {
                  //여기서 이미지를 업로드 해야 됨.
                  //올리기 완료 될 때, 화면 새로 고침해서 반영.
                },
                text: "올리기"),
            SizedBox(width: 5),
            CustomBackButton(text: "취소"),
          ],
        )
      ],
    );
  }

  Future _getImageFromCamera() async {
    XFile? _image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = _image;
    });
  }

  Future _getImageFromGallery() async {
    XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
    });
  }
}
