import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_setting_container.dart';
import 'package:fixit/main.dart';
import 'package:fixit/provider/provider.dart';
import 'package:fixit/src/app_root.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/views/about_fixit.dart';
import 'package:fixit/views/edit_profile_page.dart';
import 'package:fixit/views/our_team.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontFamily: 'ReadexPro',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<DocumentSnapshot>(
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
                  String email = data['email'] ?? '';
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 30, // Adjust the radius as needed
                        backgroundImage: profileImageUrl != null &&
                                profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                                as ImageProvider<Object>
                            : AssetImage('assets/default_avatar.png'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontFamily: 'ReadexPro',
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Color(0xff888888),
                              fontSize: 12,
                              fontFamily: 'ReadexPro',
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: Color(0xffE78125),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fixedSize: const Size(130, 23)),
                            onPressed: () {
                              AppNavigation.push(
                                context,
                                const EditProfilePage(),
                              );
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 12,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 30,
            ),
            CustomSettingContainer(
              onTap: () {},
              icon: const Icon(
                Icons.language_outlined,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'LANGUAGE',
            ),
            Consumer<UiProvider>(
              builder: (context, UiProvider notifier, child) {
                return CustomSettingContainer(
                  onTap: () {},
                  icon: const Icon(
                    Icons.nightlight,
                    color: kPrimaryColor,
                    size: 32,
                  ),
                  title: 'MOOD',
                  icon2: Switch(
                    activeTrackColor: kPrimaryColor,
                    value: notifier.isDark,
                    onChanged: (value) => notifier.changeTheme(),
                  ),
                );
              },
            ),
            CustomSettingContainer(
              onTap: () {
                AppNavigation.push(
                  context,
                  const AboutFixIt(),
                );
              },
              image: const Image(
                height: 45,
                image: AssetImage(
                  'assets/images/fixitlogo.png',
                ),
              ),
              title: 'About FIXIT',
            ),
            CustomSettingContainer(
              onTap: () {},
              icon: const Icon(
                Icons.warning_amber_outlined,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'Privacy Policy',
            ),
            CustomSettingContainer(
              onTap: () {},
              icon: const Icon(
                Icons.share_rounded,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'Share FIXIT',
            ),
            CustomSettingContainer(
              onTap: () {},
              icon: const Icon(
                Icons.rate_review_outlined,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'Your Rating',
            ),
            CustomSettingContainer(
              onTap: () {
                AppNavigation.push(
                  context,
                  const OurTeam(),
                );
              },
              icon: const Icon(
                Icons.groups,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'Our Team',
            ),
            CustomSettingContainer(
              onTap: () {
                AppNavigation.pushR(context, const AppRoot());
              },
              icon: const Icon(
                Icons.logout,
                color: kPrimaryColor,
                size: 32,
              ),
              title: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
