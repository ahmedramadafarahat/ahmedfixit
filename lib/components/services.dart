import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services(
      {super.key,
      required this.image,
      required this.service,
      required this.onTap});
  final String image;
  final String service;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: PhoneSize.phonewidth(context) * 0.03,
          vertical: PhoneSize.phoneHeight(context) * 0.02),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: PhoneSize.phoneHeight(context) * 0.15,
          width: PhoneSize.phonewidth(context) * 0.27,
          decoration: BoxDecoration(
            border: const Border(
              top: BorderSide(color: kPrimaryColor, width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: const Color(0xffEDEDED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  image,
                  height: PhoneSize.phoneHeight(context) * 0.07,
                  // image: Image.network(image),
                ),
                Text(
                  maxLines: 2,
                  service,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'ReadexPro',
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
