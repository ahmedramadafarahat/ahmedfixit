import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../components/auth_button.dart';
import '../components/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: PhoneSize.phoneHeight(context) * 0.18,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kPrimaryColor, Color(0xFF3B7FBC)]),
                color: Color(0xff1B3A56),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(200, 50),
                    bottomRight: Radius.elliptical(200, 50)),
              ),
              child: Image.asset(
                "assets/images/app_logo.png",
                scale: 3,
              ),
            ),
            SizedBox(
              height: PhoneSize.phoneHeight(context) * 0.075,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Create A New Password',
                    style: TextStyle(fontSize: 25, color: kPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        isLast: false,
                        hint: '********',
                        title: "Password",
                        obscure: true,
                        icon: Ionicons.lock_closed_outline,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.025,
                      ),
                      CustomTextFormField(
                        isLast: true,
                        hint: '********',
                        title: "Confirm Password",
                        obscure: true,
                        icon: Ionicons.lock_closed_outline,
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.025,
                      ),
                      Center(
                        child: AuthButton(
                          isHollow: false,
                          onTap: () => AppNavigation.push(
                              context, const SuccessScreen()),
                          title: 'DONE',
                        ),
                      ),
                      SizedBox(
                        height: PhoneSize.phoneHeight(context) * 0.025,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
