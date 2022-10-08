class SocialLoginModel {
  String? email;
  String? firstName;
  String? lastName;
  String? id;
  String? photoUrl;
  String? serverAuthCode;
  String? authProvider;
  String? token;

  SocialLoginModel({
    this.lastName,
    this.firstName,
    this.id,
    this.email,
    this.photoUrl,
    this.serverAuthCode,
    this.authProvider,
    this.token
  });

  Map<String, dynamic> toJson() {
    var data = {
      "id": id,
      "email": email,
      "firstname": firstName,
      "lastname": lastName,
      "photoUrl":photoUrl,
      "serverAuthCode": serverAuthCode,
      "authProvider": authProvider,
      "token": token
    };

    return data;
  }
}
