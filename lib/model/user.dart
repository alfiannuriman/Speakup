class user {
  int code;
  String info;
  String token;
  Data data;

  user({this.code, this.info, this.data});

  user.fromJson(Map<String, dynamic> json) {
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

  String full_name;
  int detail_id;
  int user_id;
  String telepon;
  String birth_date;
  String birth_place;
  String followers;
  String following;


  Data({this.full_name, this.detail_id, this.user_id, this.telepon, this.birth_date, this.birth_place, this.followers, this.following});

  Data.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    detail_id = json['detail_id'];
    user_id = json['user_id'];
    telepon = json['telepon'];
    birth_date = json['birth_date'];
    birth_place = json['birth_place'];
    following = json['following'];
    followers = json['followers'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.full_name;
    data['detail_id'] = this.detail_id;
    data['user_id'] = this.user_id;
    data['telepon'] = this.telepon;
    data['birth_place'] = this.birth_place;
    data['birth_date'] = this.birth_date;
    data['followers'] = this.followers;
    data['following'] = this.following;
    return data;
  }
}