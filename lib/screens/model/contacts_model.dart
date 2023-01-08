
import 'dart:convert';

ContactModel getContactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

class ContactModel {
  String? type;
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? user;
  String? createdAt;
  int? iV;

  ContactModel(
      {this.type,
        this.sId,
        this.name,
        this.email,
        this.phone,
        this.user,
        this.createdAt,
        this.iV});

  ContactModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    user = json['user'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user'] = this.user;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}


