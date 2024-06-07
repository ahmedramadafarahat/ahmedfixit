import 'dart:convert';
import 'package:fixit/models/categories_model.dart';
import 'package:fixit/models/citiesModel.dart';
import 'package:fixit/models/services_model.dart';
import 'package:http/http.dart' as http;

Future<List<CitiesModel>> getCities() async {
  final response = await http.get(
      Uri.parse('http://olsparkhost-001-site3.jtempurl.com/api/CitiesAPI'));
  if (response.statusCode == 200) {
    print("suceess cities");
    List<dynamic> data = jsonDecode(response.body);
    print("dattttttttttta$data");
    List<CitiesModel> cities =
        data.map((city) => CitiesModel.fromJson(city)).toList();
    return cities;
  } else {
    throw Exception('Failed to fetch cities');
  }
}
//*
Future<List<CitiesModel>> getArea() async {
  final response = await http.get(
      Uri.parse('http://olsparkhost-001-site3.jtempurl.com/api/StatesAPI'));
  if (response.statusCode == 200) {
    print("suceess Area");
    List<dynamic> data = jsonDecode(response.body);
    print("dattttttttttta$data");
    List<CitiesModel> cities =
        data.map((city) => CitiesModel.fromJson(city)).toList();
    return cities;
  } else {
    throw Exception('Failed to fetch Area');
  }
}

Future<List<ServicesModel>> getServices() async {
  http.Response response = await http.get(
      Uri.parse("http://olsparkhost-001-site3.jtempurl.com/api/ServicesAPI"));

  if (response.statusCode == 200) {
    print("Success response");
    List<dynamic> jsonData = jsonDecode(response.body);
    List<ServicesModel> servicessList =
        jsonData.map((item) => ServicesModel.fromJson(item)).toList();
    print("Services $servicessList ");
    return servicessList;
  } else {
    throw Exception('Failed to load Services');
  }
}

Future<List<ServiceCategoriesModel>> getCategories() async {
  http.Response response = await http.get(Uri.parse(
      "http://olsparkhost-001-site3.jtempurl.com/api/ServiceCategoriesAPI"));

  if (response.statusCode == 200) {
    print("Success response");
    List<dynamic> jsonData = jsonDecode(response.body);
    List<ServiceCategoriesModel> categoriesList =
        jsonData.map((item) => ServiceCategoriesModel.fromJson(item)).toList();
    print("Categories $categoriesList ");
    return categoriesList;
  } else {
    throw Exception('Failed to load Services');
  }
}
