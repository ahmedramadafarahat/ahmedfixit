import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class AboutFixIt extends StatelessWidget {
  const AboutFixIt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sasasa.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const Text(
                'FIXIT',
                style: TextStyle(
                  fontSize: 25,
                  color: kPrimaryColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'who are we ?',
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: PhoneSize.phoneHeight(context) * 0.1,
                width: PhoneSize.phonewidth(context) * 0.7,
                child: const Text(
                  'We are a site that provides the service of providing technicians to all segments of society throughoutthe Republic, andwe have technicians trained at the highest level.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff001A72),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Our goals',
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: PhoneSize.phoneHeight(context) * 0.13,
                width: PhoneSize.phonewidth(context) * 0.7,
                child: const Text(
                  'Providing various types of maintenance to users throughout the Republic and providing job opportunities for technicians',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff001A72),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
