class LoginResponseModel {
  String? token;
  String? email;
  String? profilePic;
  String? name;
  String? accountType;
  LoginResponseModel(
      {this.token, this.email, this.profilePic, this.name, this.accountType});

  LoginResponseModel.fromJson(Map<dynamic, dynamic> json) {
    token = json['key'];
    email = json['user']['email'];
    profilePic = json['user']['profile_pic'];
    name = json['user']['name'];
    accountType = json['user']['account_type'];
  }
}
