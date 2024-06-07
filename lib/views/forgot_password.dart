import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/auth_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
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
                  color: kPrimaryColor,
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
                      'Forgot Your Password',
                      style: TextStyle(fontSize: 25, color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: PhoneSize.phoneHeight(context) * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "E-Mail",
                          style: TextStyle(
                            color: Color(0xff001A72),
                            fontSize: 20,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            hintText: 'example@gmail.com',
                            prefixIcon: Container(
                              width: PhoneSize.phonewidth(context) * 0.15,
                              margin: const EdgeInsets.only(
                                top: 6,
                                bottom: 6,
                                right: 10,
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                              child: const Icon(Ionicons.mail_outline),
                            ),
                            hintStyle: const TextStyle(
                                color: Color(0xffC1BEBE), fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: PhoneSize.phoneHeight(context) * 0.025,
                        ),
                        Center(
                          child: AuthButton(
                            isHollow: false,
                            onTap: () {
                              _isLoading = true;
                              passwordReset();
                              _isLoading = false;
                            },
                            title: 'SEND',
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
      ),
    );
  }
}
