import 'package:fixit/components/auth_button.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../src/data/app_size.dart';
import 'reset_password.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                  colors: [
                    kPrimaryColor,
                    Color(0xFF3B7FBC),
                  ],
                ),
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(200, 50),
                  bottomRight: Radius.elliptical(200, 50),
                ),
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
                    'Enter The OTP Code',
                    style: TextStyle(
                      fontSize: 25,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.1,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    cursorHeight: 19,
                    enableActiveFill: true,
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldWidth: 50,
                      inactiveColor: const Color(0xffc4c4c4),
                      selectedColor: const Color(0xff373089),
                      activeFillColor: const Color(0xffc4c4c4),
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onChanged: ((value) {}),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthButton(
                    title: 'VERIFY',
                    onTap: () => AppNavigation.pushR(
                        context, const ResetPasswordScreen()),
                    isHollow: false)
              ],
            )
          ],
        ),
      ),
    );
  }
}
