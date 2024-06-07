import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/components/auth_dialog.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/curved_navigation_bar.dart';
import 'package:fixit/components/custom_divider.dart';
import 'package:fixit/main.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/auth_button.dart';
import '../../components/custom_text_field.dart';
import 'forgot_password.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();


  String? email, password;

  bool _isLoading = false;

  String? userId;
  String? userName;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
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
                        'SIGN IN NOW',
                        style: TextStyle(fontSize: 30, color: kPrimaryColor),
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
                            onChanged: (data) {
                              email = data;
                            },
                            isLast: false,
                            hint: 'example@gmail.com',
                            title: "E-Mail",
                            obscure: false,
                            icon: Ionicons.mail_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.025,
                          ),
                          CustomTextFormField(
                            onChanged: (data) {
                              password = data;
                            },
                            isLast: true,
                            hint: '********',
                            title: "Password",
                            obscure: true,
                            icon: Ionicons.lock_closed_outline,
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.025,
                          ),
                          GestureDetector(
                              onTap: () => AppNavigation.push(
                                  context, const ForgotPasswordScreen()),
                              child: const Text(
                                'Forgot Password !',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.025,
                          ),
                          Center(
                            child: AuthButton(
                              isHollow: false,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  _isLoading = true;
                                  try {
                                    await logInUser();

                                    AppNavigation.pushR(
                                        context,
                                        CurvedNavBar(
                                          userName: userName,
                                        ));
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == "invalid-credential") {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AuthDialog(
                                          errorName:
                                              "The email or password is incorrect",
                                          image: 'assets/images/warning.png',
                                          oopsOrSuccess: 'Oops !',
                                          title:
                                              'please, enter your data correctly',
                                          title2: 'try again',
                                        ),
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
                                  _isLoading = false;
                                }
                              },
                              title: 'SIGN IN',
                            ),
                          ),
                          SizedBox(
                            height: PhoneSize.phoneHeight(context) * 0.025,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New User ? ',
                          style:
                              TextStyle(fontSize: 25, color: Color(0xff8A8989)),
                        ),
                        TextButton(
                          onPressed: () =>
                              AppNavigation.pushR(context, RegisterScreen()),
                          child: const Text(
                            'SIGN UP',
                            style:
                                TextStyle(fontSize: 25, color: kPrimaryColor),
                          ),
                        )
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
                        GestureDetector(
                          onTap: () async {
                            _isLoading = true;
                            try {
                              await signInWithGoogle();
                              Navigator.pushNamed(
                                  context, const SuccessScreen() as String,
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code ==
                                  "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AuthDialog(
                                      errorName: "there is no internet",
                                      image: 'assets/images/warning.png',
                                      oopsOrSuccess: 'Oops !',
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
                                    title: 'please, enter your data correctly',
                                    title2: 'try again'),
                              );
                            }
                            _isLoading = false;
                          },
                          child: const Icon(
                            Ionicons.logo_google,
                            size: 35,
                            color: Colors.redAccent,
                          ),
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth!.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logInUser() async {
    // ignore: unused_local_variable
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    userId = user.user!.uid;
    sharedPrefrence.setString("userId", userId!);
    await fetchUserName(userId!);
  }

  Future<void> fetchUserName(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        userName = userSnapshot.get('name');
        sharedPrefrence.setString("userName", userName!);
      } else {
        print('User with ID $userId does not exist in Firestore');
      }
    } catch (e) {
      print('Error fetching username: $e');
    }
  }
}
