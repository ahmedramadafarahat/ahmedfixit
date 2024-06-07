import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog(
      {super.key,
      required this.errorName,
      required this.image,
      required this.oopsOrSuccess,
      required this.title,
      required this.title2});
  final String errorName, oopsOrSuccess, title, title2;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: PhoneSize.phonewidth(context) * 0.05,
            vertical: PhoneSize.phoneHeight(context) * 0.25),
        decoration: BoxDecoration(
            border: Border.all(
                color: kPrimaryColor, width: 2.5, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              scale: 1.3,
            ),
            Text(
              oopsOrSuccess,
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                errorName,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            GestureDetector(
              onTap: () => AppNavigation.pop(context),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  title2,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
