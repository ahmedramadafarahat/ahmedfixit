import 'package:fixit/components/constants.dart';
import 'package:flutter/material.dart';

class CustomCurrentCard extends StatelessWidget {
  const CustomCurrentCard({
    super.key,
    required this.service,
    required this.date,
    required this.colorOfCircleAvatar,
    required this.status, required this.onPressed,
  });
    final VoidCallback onPressed; // Add a delete callback

  final String service;
  final String date;
  final Color colorOfCircleAvatar;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                service,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 11,
                  fontFamily: 'ReadexPro',
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 11,
                  fontFamily: 'ReadexPro',
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: colorOfCircleAvatar,
                  ),
                  Text(
                    status,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 11,
                      fontFamily: 'ReadexPro',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: onPressed,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1.5,
            color: Color(0xff8A8989),
          ),
        ),
      ],
    );
  }
}
