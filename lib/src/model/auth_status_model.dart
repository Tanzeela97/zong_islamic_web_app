class AuthStatusModel {
  String? status;
  String? desc;
  String? statusText;

  AuthStatusModel({this.status, this.desc, this.statusText});

  AuthStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = json['desc'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['desc'] = this.desc;
    data['status_text'] = this.statusText;
    return data;
  }
}
