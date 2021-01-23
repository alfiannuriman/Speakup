class Register {
  int code;
  String info;
  Data data;

  Register({this.code, this.info, this.data});

  Register.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['info'] = this.info;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
class Data {
  String name;
  String code;
  String email;

  Data({this.name, this.code, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['email'] = this.email;
    return data;
  }
}