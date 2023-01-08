
import 'dart:convert';

UserModel getUserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  String? sId;
  String? name;
  String? email;
  String? createdAt;
  int? iV;

  UserModel({this.sId, this.name, this.email, this.createdAt, this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
