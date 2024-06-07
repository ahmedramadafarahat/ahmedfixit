import 'package:fixit/components/constants.dart';
import 'package:fixit/components/team_card.dart';
import 'package:flutter/material.dart';

class OurTeam extends StatelessWidget {
  const OurTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Our Team',
              style: TextStyle(
                fontSize: 22,
                color: kPrimaryColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'Ahmed Okal',
                track: 'Mobile App',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'Ahmed Ramdan',
                track: 'Mobile App',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'Ahmed el-shaer',
                track: 'ui/ux',
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: kPrimaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'Ahmed samir',
                track: 'graphic design',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'Ahmed zakria',
                track: 'tester',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'mariam halim',
                track: 'front end',
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: kPrimaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'doha',
                track: 'ui/ux-back end',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'rehab',
                track: 'back end',
              ),
              TeamCard(
                image: 'assets/images/the godfather.jpeg',
                name: 'asmaa',
                track: 'digital marketing',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
