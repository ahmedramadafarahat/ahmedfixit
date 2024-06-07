// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/components/auth_dialog.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_divider.dart';
import 'package:fixit/components/custom_text_field.dart';
import 'package:fixit/main.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen(
      {super.key, this.confirmPassword, this.email, this.name, this.password});
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: PhoneSize.phoneHeight(context) * 0.025,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'SIGN UP NOW',
                        style: TextStyle(fontSize: 30, color: kPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: PhoneSize.phoneHeight(context) * 0.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            onChanged: (data) {
                              widget.name = data;
                            },
                            isLast: false,
                            hint: 'John Smith',
                            title: "Full Name",
                            obscure: false,
                            icon: Ionicons.person_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.01,
                          ),
                          CustomTextFormField(
                            onChanged: (data) {
                              widget.email = data;
                            },
                            isLast: false,
                            hint: 'example@gmail.com',
                            title: "E-Mail",
                            obscure: false,
                            icon: Ionicons.mail_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.01,
                          ),
                          CustomTextFormField(
                            onChanged: (data) {
                              widget.password = data;
                            },
                            isLast: false,
                            hint: '********',
                            title: "Password",
                            obscure: true,
                            icon: Ionicons.lock_closed_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.01,
                          ),
                          CustomTextFormField(
                            onChanged: (data) {
                              widget.confirmPassword = data;
                            },
                            isLast: true,
                            hint: '********',
                            title: "Confirm Password",
                            obscure: true,
                            icon: Ionicons.lock_closed_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.01,
                          ),
                          Center(
                            child: AuthButton(
                              isHollow: false,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    if (widget.password !=
                                        widget.confirmPassword) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AuthDialog(
                                          title:
                                              'please, enter your data correctly',
                                          title2: 'try again',
                                          errorName: "Password does not match",
                                          image: 'assets/images/warning.png',
                                          oopsOrSuccess: 'Oops !',
                                        ),
                                      );
                                    } else if (widget.password ==
                                        widget.confirmPassword) {
                                      await registerUser();
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AuthDialog(
                                            errorName: "congratulation",
                                            image: 'assets/icons/done.png',
                                            oopsOrSuccess: "success !",
                                            title: '',
                                            title2: 'log in'),
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'email-already-in-use') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AuthDialog(
                                            errorName:
                                                "the account already exists for that email",
                                            image: 'assets/images/warning.png',
                                            oopsOrSuccess: 'Oops!',
                                            title:
                                                'please, enter your data correctly',
                                            title2: 'try again'),
                                      );
                                    } else if (widget.password!.length < 8) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AuthDialog(
                                            errorName:
                                                "Password must be atleast 8 characters long",
                                            image: 'assets/images/warning.png',
                                            oopsOrSuccess: 'Oops!',
                                            title:
                                                'please, enter your data correctly',
                                            title2: 'try again'),
                                      );
                                    }
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const AuthDialog(
                                          errorName:
                                              "there was an error please try again latter",
                                          image: 'assets/images/warning.png',
                                          oopsOrSuccess: 'Oops !',
                                          title:
                                              'please, enter your data correctly',
                                          title2: 'try again'),
                                    );
                                  }
                                }
                              },
                              title: 'SIGN UP',
                            ),
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.01,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already Have Account?',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff8A8989)),
                        ),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.pushR(
                              context,
                              const LoginScreen(),
                            );
                          },
                          child: const Text(
                            ' Login Here',
                            style:
                                TextStyle(fontSize: 15, color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PhoneSize.phoneHeight(context) * 0.025,
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: PhoneSize.phoneHeight(context) * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Ionicons.logo_facebook,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: PhoneSize.phonewidth(context) * 0.025,
                        ),
                        const Icon(
                          Ionicons.logo_apple,
                          color: Colors.black,
                          size: 35,
                        ),
                        SizedBox(
                          width: PhoneSize.phonewidth(context) * 0.025,
                        ),
                        const Icon(
                          Ionicons.logo_google,
                          size: 35,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PhoneSize.phoneHeight(context) * 0.025,
                    ),
                    const Text(
                      'Sign In With Another Account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffC1BEBE),
                      ),
                    ),
                    SizedBox(
                      height: PhoneSize.phoneHeight(context) * 0.005,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: widget.email!,
      password: widget.password!,
    );
    String uid = user.user!.uid; // Get the UID of the user

    saveUserDataToFirestore(uid, widget.email!, widget.password!);
  }

  Future<void> saveUserDataToFirestore(
      String uid, String email, String password) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users
          .doc(uid)
          .set({'email': email, 'phone': password, 'name': widget.name});

      print('User data saved to Firestore');
      sharedPrefrence.setString('email', email);
      sharedPrefrence.setString('name', widget.name!);

    } catch (e) {
      print('Error saving user data to Firestore: $e');
    }
  }
}
