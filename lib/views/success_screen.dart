import 'package:fixit/components/auth_button.dart';
import 'package:fixit/components/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../src/data/app_navigation.dart';
import '../src/data/app_size.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/fingers.png'),
              SizedBox(
                height: PhoneSize.phoneHeight(context) * 0.08,
              ),
              const Text(
                'Success',
                style: TextStyle(
                    fontSize: 50,
                    color: Color(0XFF001A72),
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'Congratulations !',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0XFF8A8989),
                ),
              ),
              SizedBox(
                height: PhoneSize.phoneHeight(context) * 0.04,
              ),
              AuthButton(
                  title: 'CONTINUE',
                  onTap: () => AppNavigation.push(
                        context,
                         CurvedNavBar(),
                      ),
                  isHollow: false)
            ],
          ),
        ),
      ),
    );
  }
}
