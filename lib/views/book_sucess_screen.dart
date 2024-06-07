import 'package:fixit/components/constants.dart';
import 'package:fixit/components/curved_navigation_bar.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:flutter/material.dart';

class BookSuccess extends StatelessWidget {
  const BookSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Image(
              height: 375,
              width: double.infinity,
              image: AssetImage(
                'assets/images/done.png',
              ),
            ),
            const Text(
              'Success',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xff001A72),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Congratulations !',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff8A8989),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () {
                  AppNavigation.pushR(
                    context,
                     CurvedNavBar(),
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
