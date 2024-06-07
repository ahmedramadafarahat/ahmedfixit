import 'package:fixit/components/constants.dart';
import 'package:flutter/material.dart';

import '../src/data/app_size.dart';

class CustomPreviousCard extends StatelessWidget {
  const CustomPreviousCard({
    super.key,
    required this.image,
    required this.name,
    required this.service,
    required this.time,
  });
  final String image;
  final String name;
  final String service;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10)),
        height: PhoneSize.phoneHeight(context) * 0.16,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: PhoneSize.phonewidth(context) * 0.3,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  image,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'ReadexPro',
                  ),
                ),
                Text(
                  service,
                  style: const TextStyle(
                    color: Color(0xffF2A365),
                    fontSize: 12,
                    fontFamily: 'ReadexPro',
                  ),
                ),
                SizedBox(
                  width: PhoneSize.phonewidth(context) * 0.45,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'ReadexPro',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        color: Colors.white,
                        Icons.access_time,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
