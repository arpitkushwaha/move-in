class User{
  int id;
  String email;
  String password;
  String number;

  User(
  {this.id,this.email, this.password, this.number});

  User.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  email = json['email'];
  password = json['password'];
  number = json['number'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['email'] = this.email;
  data['password'] = this.password;
  data['number'] = this.number;
  return data;
  }
}