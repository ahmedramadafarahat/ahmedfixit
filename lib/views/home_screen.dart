import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_app_bar.dart';
import 'package:fixit/components/custom_circle_avatar.dart';
import 'package:fixit/components/most_popular_services.dart';
import 'package:fixit/components/recommended_for_you.dart';
import 'package:fixit/service_screens/electricsscreen.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:fixit/views/services_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});
  final String userName;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  List imgList = ['assets/images/1.jpg', 'assets/images/2.jpg'];
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          userName: widget.userName,
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: .26 * MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                CarouselSlider(
                  items: imgList
                      .map((item) => Container(
                            child: Container(
                              margin: const EdgeInsets.all(10.5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(9.0),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Image.asset(item,
                                        fit: BoxFit.cover, width: 1000.0),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1.9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 15.0,
                        height: 3.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 3.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : kPrimaryColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.0012,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Choose Service',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ReadexPro',
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ServicesScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'ReadexPro',
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.114,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CustomCircleAvatar(
                    image: 'assets/images/electricity.jpg',
                    onTap: () {
                      AppNavigation.push(
                        context,
                        const Electrics(),
                      );
                    }),
                CustomCircleAvatar(
                    image: 'assets/images/water.jpg',
                    onTap: () {
                      AppNavigation.push(
                        context,
                        const Water(),
                      );
                    }),
                CustomCircleAvatar(
                    image: 'assets/images/carpentry.jpg',
                    onTap: () {
                      AppNavigation.push(
                        context,
                        const Carpentry(),
                      );
                    }),
                CustomCircleAvatar(
                    image: 'assets/images/home_service.jpg',
                    onTap: () {
                      AppNavigation.push(
                        context,
                        const HomeService(),
                      );
                    }),
                CustomCircleAvatar(
                  image: 'assets/images/coiffeur.jpg',
                  onTap: () {
                    AppNavigation.push(
                      context,
                      const Coiffeur(),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.01,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Most Popular Services',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ReadexPro',
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'ReadexPro',
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MostPopularServices(
                  image: 'assets/icons/electricityIcon.png',
                  service: '    Electricity',
                  discount: '20% OFF ',
                ),
                MostPopularServices(
                  image: 'assets/icons/home_serviceIcon.png',
                  service: ' Home service',
                  discount: '30% OFF ',
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Divider(
              color: kPrimaryColor,
              thickness: 3,
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Top Technicians',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ReadexPro',
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'ReadexPro',
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.035,
          ),
          SizedBox(
            height: PhoneSize.phoneHeight(context) * 0.2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    RecommendedForYou(
                        name: 'Ahmed Ramadan',
                        lastStar: Icons.star,
                        rate: '(190)',
                        service: 'electricity'),
                    Align(
                        alignment: FractionalOffset(2, -0.2),
                        child: CircleAvatar(
                          foregroundColor: kPrimaryColor,
                          backgroundColor: Color(0xFFD8D8D8),
                          radius: 30,
                          child: Icon(
                            Icons.person_outline,
                          ),
                        )),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    RecommendedForYou(
                        name: 'Ahmed Okal',
                        lastStar: Icons.star,
                        rate: '(190)',
                        service: 'water'),
                    Align(
                        alignment: FractionalOffset(2, -0.2),
                        child: CircleAvatar(
                          foregroundColor: kPrimaryColor,
                          backgroundColor: Color(0xFFD8D8D8),
                          radius: 30,
                          child: Icon(
                            Icons.person_outline,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
