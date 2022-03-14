class TokenStatus {
  String? message;
  String? jwt;
  int? expireAt;

  TokenStatus({this.message, this.jwt, this.expireAt});

  TokenStatus.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    jwt = json['jwt'];
    expireAt = json['expireAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['jwt'] = this.jwt;
    data['expireAt'] = this.expireAt;
    return data;
  }
}
