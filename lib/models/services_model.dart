import 'package:flutter/src/widgets/framework.dart';

class ServicesModel {
  int? id;
  int? catId;
  String? name;
  String? icon;

  ServicesModel({this.id, this.catId, this.name, this.icon});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    catId = json['Cat_Id'];
    name = json['Name'];
    icon = json['Icon'];
  }

  // Widget get route => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Cat_Id'] = this.catId;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    return data;
  }
}
