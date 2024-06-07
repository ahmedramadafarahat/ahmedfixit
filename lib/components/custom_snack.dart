import 'package:flutter/material.dart';

CustomSnackBar(BuildContext context, String text, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.white,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.sizeOf(context).height - 140,
        left: 10,
        right: 10,
      ),
      content: Text(text)));
}