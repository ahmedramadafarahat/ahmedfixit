class ServiceCategoriesModel {
  int? id;
  String? title;
  String? iCon;
  String? src;

  ServiceCategoriesModel({this.id, this.title, this.iCon, this.src});

  ServiceCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    iCon = json['ICon'];
    src = json['Src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['ICon'] = this.iCon;
    data['Src'] = this.src;
    return data;
  }
}