import 'package:flutter/material.dart';

import '../src/data/app_size.dart';

class RecommendedForYou extends StatelessWidget {
  const RecommendedForYou(
      {super.key,
      required this.name,
      required this.lastStar,
      required this.rate,
      required this.service});
  final String name;
  final IconData lastStar;
  final String rate;
  final String service;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: PhoneSize.phoneHeight(context) * 0.18,
        width: PhoneSize.phonewidth(context) * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xffF8E755),
                ),
                const Icon(
                  Icons.star,
                  color: Color(0xffF8E755),
                ),
                const Icon(
                  Icons.star,
                  color: Color(0xffF8E755),
                ),
                const Icon(
                  Icons.star,
                  color: Color(0xffF8E755),
                ),
                Icon(
                  lastStar,
                  color: const Color(0xffF8E755),
                ),
              ],
            ),
            Text(
              rate,
              style: const TextStyle(
                color: Color(0xffA5A3A3),
              ),
            ),
            Text(service),
          ],
        ),
      ),
    );
  }
}
