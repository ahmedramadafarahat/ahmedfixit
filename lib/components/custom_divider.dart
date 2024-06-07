import 'package:fixit/components/constants.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            endIndent: 20,
            color: kPrimaryColor,
            indent: 80,
          ),
        ),
        Text(
          'OR',
          style: TextStyle(
            fontSize: 18,
            color: kPrimaryColor,
          ),
        ),
        Expanded(
          child: Divider(
            endIndent: 80,
            color: kPrimaryColor,
            indent: 20,
          ),
        ),
      ],
    );
  }
}
