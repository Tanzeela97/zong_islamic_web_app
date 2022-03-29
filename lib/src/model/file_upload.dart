class FileUpload {
  bool? status;
  bool? error;
  String? message;
  String? url;

  FileUpload({this.status, this.error, this.message, this.url});

  FileUpload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    data['url'] = url;
    return data;
  }

}