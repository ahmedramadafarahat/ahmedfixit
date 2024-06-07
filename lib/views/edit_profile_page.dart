import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_text_field.dart';
import 'package:fixit/src/data/upload_image.dart';
import 'package:fixit/main.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<File> _images = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEDED),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPrefrence.getString("userId"))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('User not found');
            }

            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String profileImageUrl = data['profileImageURL'] ?? '';
            String userName = data['name'] ?? '';
          
            return ListView(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: kPrimaryColor,
                  child: GestureDetector(
                    onTap: () async {
                      await _getImages();
                    },
                    child: _images.isNotEmpty
                        ? ClipOval(
                            child: Image.file(
                              _images.first,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          )
                        : profileImageUrl.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  profileImageUrl,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              )
                            : Icon(Icons.edit, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        isLast: false,
                        hint: userName ?? "",
                        title: "Full Name",
                        obscure: false,
                        icon: Ionicons.person_outline, readOnly: false,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.01,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        isLast: false,
                        hint: sharedPrefrence.getString("email")!,
                        title: "E-Mail",
                        obscure: false,
                        icon: Ionicons.mail_outline, readOnly: true,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.01,
                      ),
                      CustomTextFormField(
                        isLast: false,
                        hint: '********',
                        title: "Password",
                        obscure: true,
                        icon: Ionicons.lock_closed_outline, readOnly: true,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.01,
                      ),
                      CustomTextFormField(
                        isLast: true,
                        hint: '********',
                        title: "Confirm Password",
                        obscure: true,
                        icon: Ionicons.lock_closed_outline, readOnly: true,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Governorate',
                            style: TextStyle(
                              color: Color(0xff001A72),
                              fontSize: 20,
                            ),
                          ),
                          DropdownMenu(
                            trailingIcon:
                                const Icon(Icons.arrow_drop_down_sharp),
                            inputDecorationTheme: const InputDecorationTheme(
                              hintStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.81,
                            onSelected: (value) {},
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: 1,
                                label: 'Gharbia',
                                labelWidget: Text(
                                  'Gharbia',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                            hintText: 'Gharbia',
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'City',
                            style: TextStyle(
                              color: Color(0xff001A72),
                              fontSize: 20,
                            ),
                          ),
                          DropdownMenu(
                            trailingIcon:
                                const Icon(Icons.arrow_drop_down_sharp),
                            inputDecorationTheme: const InputDecorationTheme(
                              hintStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.81,
                            onSelected: (value) {},
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: 1,
                                label: 'Tanta',
                                labelWidget: Text(
                                  'Tanta',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              DropdownMenuEntry(
                                value: 2,
                                label: 'El-Mahalla El-Kubra',
                                labelWidget: Text("El-Mahalla El-Kubra"),
                              ),
                              DropdownMenuEntry(
                                value: 3,
                                label: 'Qutor',
                                labelWidget: Text(
                                  'Qutor',
                                ),
                              ),
                              DropdownMenuEntry(
                                value: 4,
                                label: 'Basyoun',
                                labelWidget: Text("Basyoun"),
                              ),
                              DropdownMenuEntry(
                                value: 5,
                                label: 'Kafr El Zayat',
                                labelWidget: Text(
                                  'Kafr El Zayat',
                                ),
                              ),
                              DropdownMenuEntry(
                                value: 6,
                                label: 'El Santa',
                                labelWidget: Text("El Santa"),
                              ),
                              DropdownMenuEntry(
                                value: 7,
                                label: 'Zefta',
                                labelWidget: Text("Zefta"),
                              ),
                              DropdownMenuEntry(
                                value: 8,
                                label: 'Samanoud',
                                labelWidget: Text("Samanoud"),
                              ),
                            ],
                            hintText: 'Tanta',
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 50),
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              await saveUserData();
                              await uploadImagesToFirebase(
                                  sharedPrefrence.getString("userId")!,
                                  _images);
                            },
                            child: const Text(
                              'Save',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<void> _uploadImagesToFirebase(List<File> images) async {
    try {
      final firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref('usersImages');

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

  Future<void> saveUserData() async {
    try {
      String userId = sharedPrefrence.getString('userId')!;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': nameController.text.isNotEmpty? nameController.text: sharedPrefrence.getString('name'),
      'email':sharedPrefrence.getString('email')
        // Add other fields to update here...
      });
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
