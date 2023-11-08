class ImageModal {
  String? contentType;
  String? extension;
  String? md5;
  String? previewUrl;

  ImageModal({this.contentType, this.extension, this.md5, this.previewUrl});

  ImageModal.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    extension = json['extension'];
    md5 = json['md5'];
    previewUrl = json['previewUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['contentType'] = this.contentType;
    data['extension'] = this.extension;
    data['md5'] = this.md5;
    data['previewUrl'] = this.previewUrl;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
