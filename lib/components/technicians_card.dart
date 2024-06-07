import 'package:fixit/components/constants.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/book_screen.dart';
import 'package:flutter/material.dart';

import '../src/data/app_navigation.dart';

class TechniciansCard extends StatelessWidget {
  const TechniciansCard(
      {super.key,
      required this.image,
      required this.name,
      required this.city,
      required this.service});
  final String image;
  final String name;
  final String service;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        height: PhoneSize.phoneHeight(context) * 0.20,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: PhoneSize.phonewidth(context) * 0.4,
              child: Image(
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                image: NetworkImage(
                  image,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'Image failed to load',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    service,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      color: Color(0xfff2a365),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        city,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xffF8E755),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffF8E755),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffF8E755),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffF8E755),
                      ),
                      Icon(
                        Icons.star_half,
                        color: Color(0xffF8E755),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        AppNavigation.push(
                            context,
                            BookScreen(
                              name: service,
                            ));
                      },
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
