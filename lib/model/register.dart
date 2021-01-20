class Register {
  String email;
  String username;
  String password;

  Register({this.email, this.username, this.password});

  Register.fromJson(Map<String, dynamic> json) {
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}