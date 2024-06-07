import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  const TeamCard(
      {super.key,
      required this.image,
      required this.name,
      required this.track});
  final String image;
  final String name;
  final String track;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: PhoneSize.phoneHeight(context) * 0.17,
        width: PhoneSize.phonewidth(context) * 0.29,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffE78125),
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            SizedBox(
              height: PhoneSize.phoneHeight(context) * 0.1,
              width: double.infinity,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  image,
                ),
              ),
            ),
            SizedBox(
              height: PhoneSize.phoneHeight(context) * 0.01,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                color: kPrimaryColor,
              ),
            ),
            Text(
              track,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xff83919E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
