// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/components/auth_dialog.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/curved_navigation_bar.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/login_screen.dart';
import 'package:fixit/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/auth_button.dart';
import '../components/custom_divider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back To',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                const Text(
                  'Fixit !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Image.asset(
                  'assets/images/app_logo.png',
                ),
                AuthButton(
                  isHollow: true,
                  onTap: () {
                    AppNavigation.push(context, const LoginScreen());
                  },
                  title: 'SIGN IN',
                ),
                AuthButton(
                  isHollow: false,
                  onTap: () {
                    AppNavigation.push(context, RegisterScreen());
                  },
                  title: 'SIGN UP',
                ),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.025,
                ),
                const CustomDivider(),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.05,
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
                          AppNavigation.pushR(context, CurvedNavBar());
                        } on FirebaseAuthException catch (e) {
                          if (e.code ==
                              "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
                            showDialog(
                              context: context,
                              builder: (context) => const AuthDialog(
                                  errorName: "there is no internet",
                                  image: 'assets/images/warning.png',
                                  oopsOrSuccess: 'Oops !',
                                  title: 'please, enter your data correctly',
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
                  height: PhoneSize.phoneHeight(context) * 0.03,
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
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
