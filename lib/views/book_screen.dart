import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_book_text_field.dart';
import 'package:fixit/components/custom_snack.dart';
import 'package:fixit/main.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/book_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:uuid/uuid.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.name});
  final String name;
  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final TextEditingController _dateController = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController payment = TextEditingController();
  List<File> _images = [];

  String?
      selectedPaymentOption; // Variable to store the selected payment option

  final List<String> paymentOptions = [
    'Cash',
    'Credit Card',
    'Mobile Payment',
    // Add more options as needed
  ];
  void _showPaymentOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Payment Method'),
          content: DropdownButton<String>(
            value: selectedPaymentOption,
            items: paymentOptions.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedPaymentOption = value;
              });
              Navigator.pop(context); // Close the dialog
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Image(
                  height: PhoneSize.phoneHeight(context) * 0.15,
                  width: PhoneSize.phonewidth(context) * 0.25,
                  image: const AssetImage(
                    'assets/images/Don.jpg',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ahmed okal',
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'water service',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffF2A365),
                          fontFamily: 'ReadexPro',
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: kPrimaryColor,
                          ),
                          Text(
                            'tanta',
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                border: const Border(
                  top: BorderSide(color: kPrimaryColor, width: 4),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      'Book Now !',
                      style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                  ),
                  CustomBookTextField(
                    readOnly: false,
                    title: 'Description Of The  Problem',
                    maximumLines: 4,
                    controller: des,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: const Border(
                          top: BorderSide(color: kPrimaryColor, width: 4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: _images.isNotEmpty
                          ? Image.file(_images.first)
                          : GestureDetector(
                              onTap: () async {
                                await _getImages();
                                await _uploadImagesToFirebase(_images);
                              },
                              child: Container(
                                height: 60,
                                width: 170,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffD9D9D9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      height: 30,
                                      image: AssetImage(
                                        'assets/icons/camera.png',
                                      ),
                                    ),
                                    Text(
                                      'Upload Image',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  CustomBookTextField(
                    readOnly: false,
                    title: 'Address',
                    maximumLines: 1,
                    controller: adress,
                  ),
                  CustomBookTextField(
                    readOnly: false,
                    title: 'Phone',
                    maximumLines: 1,
                    controller: phone,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: const Border(
                          top: BorderSide(color: kPrimaryColor, width: 4),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _dateController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          hintText: 'Date and Time',
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'payment ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      value: selectedPaymentOption,
                      items: paymentOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedPaymentOption = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () async {
                        await _uploadData(
                            context, sharedPrefrence.getString('userId')!);
                      },
                      child: const Text(
                        'Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _uploadData(BuildContext context, String userId) async {
    try {
      // Check if any field is empty
      if (adress.text.isEmpty ||
          des.text.isEmpty ||
          phone.text.isEmpty ||
          selectedPaymentOption == '' ||
          _dateController.text.isEmpty) {
        CustomSnackBar(context, "Please fill in all fields", Colors.red);
        return;
      }
      // Get a reference to the Firestore database
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add data to the 'orders' collection
      await firestore.collection('orders').add({
        "name": widget.name,
        'userId': userId, // Add the current user's ID
        'address': adress.text,
        'description': des.text,
        'phone': phone.text,
        'payment': selectedPaymentOption,
        'date': _dateController.text,
        'status': "accepted",
      });

      // Clear the text fields after uploading
      adress.clear();
      des.clear();
      phone.clear();
      payment.clear();
      _dateController.clear();

      // Show a success message
      CustomSnackBar(context, "Uploaded data successfully", Colors.green);
      AppNavigation.push(
        context,
        const BookSuccess(),
      );
    } catch (e) {
      // Show an error message if uploading fails
      CustomSnackBar(context, 'Error uploading data: $e', Colors.red);
    }
  }

  Future<void> _getImages() async {
    List<Asset> pickedImages = [];
    try {
      pickedImages = await MultiImagePicker.pickImages();
    } catch (e) {
      print('Error picking images: $e');
    }

    if (pickedImages.isNotEmpty) {
      List<File> images = [];
      for (var pickedImage in pickedImages) {
        try {
          final ByteData byteData = await pickedImage.getByteData();
          final List<int> imageData = byteData.buffer.asUint8List();
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${pickedImage.name}');
          await tempFile.writeAsBytes(imageData);
          images.add(tempFile);
        } catch (e) {
          print('Error converting asset to file: $e');
        }
      }
      setState(() {
        _images = images;
      });
    }
  }

  Future<void> _uploadImagesToFirebase(List<File> images) async {
    try {
      final firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref('serviceImage');

      for (int i = 0; i < images.length; i++) {
        final File image = images[i];
        // Generate a unique name for each image using UUID
        final String uuid = Uuid().v4();
        final firebase_storage.Reference ref = storageRef
            .child('image_$uuid.jpg'); // Use a unique name for each image
        await ref.putFile(image);
        print('Image $i uploaded to Firebase Storage');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }
}
