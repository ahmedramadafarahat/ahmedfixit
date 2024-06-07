import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const WelcomeScreen();
              },
            )));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: PhoneSize.phoneHeight(context) * 0.25,
                width: PhoneSize.phonewidth(context),
                image: const AssetImage(
                  'assets/images/splash_logo.png',
                ),
              ),
              const Text(
                'FIXIT',
                style: TextStyle(
                  fontSize: 60,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your solution is here',
                style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                ),
              ),
              LottieBuilder.asset(
                  'assets/animation/Animation - 1710098562431.json')
            ],
          ),
        ),
      ),
    );
  }
}
