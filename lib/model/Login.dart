class Login {
  int code;
  String info;
  String token;
  Data data;

  Login({this.code, this.info, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
    info = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['info'] = this.info;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String user_id;
  String code;
  String name;
  String email;
  String token;

  Data({this.user_id, this.code, this.name, this.email, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    name = json['name'];
    code = json['code'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}