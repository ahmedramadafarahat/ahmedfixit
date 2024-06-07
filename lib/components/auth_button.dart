import 'package:fixit/components/constants.dart';
import 'package:flutter/material.dart';

import '../src/data/app_size.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isHollow});
  final String title;
  final VoidCallback onTap;
  final bool isHollow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 13),
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: PhoneSize.phonewidth(context) * 0.15),
        decoration: BoxDecoration(
            color: isHollow ? Colors.white : kPrimaryColor,
            border: Border.all(
                width: 3, color: isHollow ? kPrimaryColor : Colors.white),
            borderRadius: BorderRadius.circular(7)),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 25, color: isHollow ? kPrimaryColor : Colors.white),
        ),
      ),
    );
  }
}
