class PhotoUploadDto {
  final String photo;
  final String content;
  final String militaryNumber;

  PhotoUploadDto(this.photo, this.content, this.militaryNumber);
  Map<String, dynamic> toJson() => {
        "photo": photo,
        "content": content,
        "militaryNumber": militaryNumber,
      };
}
