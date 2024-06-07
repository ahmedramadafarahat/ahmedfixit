import 'dart:convert';

import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_dropdown%20city.dart';
import 'package:fixit/components/custom_dropdown%20govern.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

import '../models/categories_model.dart';
import '../models/citiesModel.dart';
import '../src/data/api.dart';
import 'custom_dropdown.dart';
import 'package:http/http.dart' as http;

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  String? selectedCityId;
  String? selectedServiceId;
  String? selectedAreaId;
  Future<void> fetchData() async {
    if (selectedCityId != null) {
      String url = 'https://olsparkhost-001-site3.jtempurl.com/api/FilterTechnicalApi?city_id=$selectedCityId&services_id=$selectedServiceId&state_id=$selectedAreaId';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON data
        var data = json.decode(response.body);
        print(data); // For now, just print the data for debugging


        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Data'),
            content: Text(data.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle the error
        print('Failed to load data');
      }
    } else {
      // Show a message or handle the case where no city is selected
      print('Please select a city.');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: PhoneSize.phonewidth(context) * 0.02,
            vertical: PhoneSize.phoneHeight(context) * 0.15),
        decoration: BoxDecoration(
            border: Border.all(
                color: kPrimaryColor,
                width: 2.5,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        FutureBuilder<List<ServiceCategoriesModel>>(
        future: getCategories(), // Fetch categories from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error
            return Text('Error loading categories');
          } else {
            // If data loaded successfully
            List<ServiceCategoriesModel> categories = snapshot.data!;
            return DropdownMenu(
              trailingIcon: Icon(Icons.arrow_drop_down_sharp),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              onSelected: (value) {
                setState(() {
                  selectedServiceId = value as String?;
                });
              },
              dropdownMenuEntries: [
                for (var category in categories)
                  DropdownMenuEntry(
                    value: category.id, // Assuming each category has an id
                    label: category.title!, // Assuming each category has a name
                    labelWidget: Text(
                      category.title!, // Assuming each category has a name
                    ),
                  ),
              ],
              hintText: 'CHOOSE THE PROBLEM',
            );
          }
        },
      ),
           FutureBuilder<List<CitiesModel>>(
      future: getCities(), // Fetch cities from API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error
          return Text('Error loading cities');
        } else {
          // If data loaded successfully
          List<CitiesModel> cities = snapshot.data!;
          return DropdownMenu(
            trailingIcon: Icon(Icons.arrow_drop_down_sharp),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            onSelected: (value) {
              setState(() {
                selectedCityId = value as String?;
              });
            },
            dropdownMenuEntries: [
              for (var city in cities)
                DropdownMenuEntry(
                  value: city.id,
                  label: city.name,
                  labelWidget: Text(city.name),
                ),
            ],
            hintText: 'IN THIS CITY',
          );
        }
      },
    ),
        FutureBuilder<List<CitiesModel>>(
          future: getArea(), // Fetch cities from API
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there's an error
              return Text('Error loading Areas');
            } else {
              // If data loaded successfully
              List<CitiesModel> cities = snapshot.data!;
              return DropdownMenu(
                trailingIcon: Icon(Icons.arrow_drop_down_sharp),
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                onSelected: (value) {
                  setState(() {
                    selectedAreaId= value as String?;
                  });
                },
                dropdownMenuEntries: [
                  for (var city in cities)
                    DropdownMenuEntry(
                      value: city.id,
                      label: city.name,
                      labelWidget: Text(city.name),
                    ),
                ],
                hintText: 'IN THIS AREA',
              );
            }
          },
        ),
                                                                                GestureDetector(
                                                                                  onTap:  fetchData,
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets.only(top: 10),
                                                                                    padding:
                                                                                        const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: kPrimaryColor,
                                                                                        borderRadius: BorderRadius.circular(10)),
                                                                                    child: const Text(
                                                                                      "S E A R C H",
                                                                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                    ),
                                                                                  ),
                                                                                ),
          ],
        ),
      ),
    );
  }
}
