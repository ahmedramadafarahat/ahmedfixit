import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../src/data/app_size.dart';
import 'search_dialog.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: StreamBuilder<DocumentSnapshot>(
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

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            String profileImageUrl = data['profileImageURL'] ?? '';
            String userName = data['name'] ?? '';
            return Row(
              children: [
                CircleAvatar(
                  radius: 20, // Adjust the radius as needed
                  backgroundImage: profileImageUrl != null &&
                          profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl) as ImageProvider<Object>
                      : AssetImage('assets/images/the godfather.jpeg'),
                ),

                SizedBox(
                  width: PhoneSize.phonewidth(context) * 0.02,
                ),
                Column(
                  children: [
                    Text(
                      'welcome back',
                      style: TextStyle(
                        fontFamily: 'ReadexPro',
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ReadexPro',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.notifications,
                //     size: 30,
                //     color: Color(0xff1B3A56),
                //   ),
                // ),
                IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const SearchDialog()),
                  icon: const Icon(
                    Icons.tune_sharp,
                    size: 30,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
