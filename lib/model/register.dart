class Register {
  Data data;

  Register({this.data});

  Register.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
class Data {
  String token;
  String name;
  String code;
  String email;

  Data({this.token, this.name, this.code, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    code = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['email'] = this.email;
    return data;
  }
}