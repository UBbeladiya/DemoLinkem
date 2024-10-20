class UserProfileModel {
  String? message;
  User? user;
  String? token;
  String? imageUrl;

  UserProfileModel({this.message, this.user, this.token, this.imageUrl});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? status;
  String? link;
  String? image;
  String? emailVerifiedAt;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
        this.email,
        this.status,
        this.link,
        this.image,
        this.emailVerifiedAt,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    status = json['status'];
    link = json['link'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['link'] = this.link;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
