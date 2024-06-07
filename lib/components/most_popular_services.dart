import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class MostPopularServices extends StatelessWidget {
  const MostPopularServices(
      {super.key,
      required this.image,
      required this.service,
      required this.discount});
  final String image;
  final String service;
  final String discount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: PhoneSize.phoneHeight(context) * 0.15,
        width: PhoneSize.phonewidth(context) * 0.46,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: const Border(
            top: BorderSide(color: kPrimaryColor, width: 4),
          ),
          color: const Color(0xffF1F0F0),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: PhoneSize.phoneHeight(context) * 0.02,
                  horizontal: PhoneSize.phonewidth(context) * 0.01),
              child: Image(image: AssetImage(image)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: PhoneSize.phonewidth(context) * 0.25,
                  child: Text(
                    service,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kPrimaryColor,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                ),
                SizedBox(
                  height: PhoneSize.phoneHeight(context) * 0.01,
                ),
                Text(
                  discount,
                  style: const TextStyle(
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
