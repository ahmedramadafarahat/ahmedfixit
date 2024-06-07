import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Future<void> uploadImagesToFirebase(String userId, List<File> images) async {
  try {
    final firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('usersImages/$userId');

    for (int i = 0; i < images.length; i++) {
      final File image = images[i];
      // Generate a unique name for each image using UUID
      final String uuid = Uuid().v4();
      final firebase_storage.Reference ref = storageRef.child('image_$uuid.jpg'); // Use a unique name for each image
      await ref.putFile(image);
      final String downloadURL = await ref.getDownloadURL();

      // Save the download URL to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profileImageURL': downloadURL,
      });

      print('Image $i uploaded to Firebase Storage and URL saved to Firestore');
    }
  } catch (e) {
    print('Error uploading images: $e');
  }
}
