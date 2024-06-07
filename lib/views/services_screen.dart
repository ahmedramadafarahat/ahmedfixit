import 'package:fixit/components/constants.dart';
import 'package:fixit/components/services.dart';
import 'package:fixit/models/categories_model.dart';
import 'package:fixit/models/services_model.dart';
import 'package:fixit/service_screens/electricsscreen.dart';
import 'package:fixit/src/data/api.dart';
import 'package:fixit/src/data/app_navigation.dart';
import 'package:fixit/src/data/app_size.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List route = [
      Electrics(),
      Water(),
      Carpentry(),
      HomeService(),
      BuildingWork(),
      InsulationWork(),
      RoadWork(),
      SmithWork(),
      MobileMaintenance(),
      ShippingAndDelivery(),
      Mechanical(),
      Coiffeur(),
      BabySitter(),
      ElderlySitter(),
      MedicalEquipmentMaintenance(),
      ComputerMaintenance(),
      ElevatorTechnician(),
      Farmer(),
      Painting(),
      GraphicDesign(),
      GasInstallation(),
      Driver(),
      CalligrapherAndPainter(),
      DDesign(),
    ];
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SizedBox(
                height: PhoneSize.phoneHeight(context) * 0.12,
                child: const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Which ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                            Text(
                              'Service',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'do you',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                        Text(
                          'need?',
                          style: TextStyle(
                            color: Color(0xffD79663),
                            fontSize: 20,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                      image: AssetImage(
                          'assets/images/which_service_do_you_need.png'),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<ServicesModel>>(
              future: getServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While data is loading
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // If there's an error
                  return Center(
                    child: Text('Error loading categories'),
                  );
                } else {
                  // If data loaded successfully
                  List<ServicesModel> services = snapshot.data!;
                  print('object services ${services[0].name}');
                  return Column(
                    children: [
                      for (int i = 0; i < services.length; i += 3)
                        Row(
                          children: [
                            for (int j = i;
                                j < i + 3 && j < services.length;
                                j++)
                              Services(
                                image:
                                    "http://olsparkhost-001-site3.jtempurl.com/${services[j].icon!}",
                                service: services[j].name!,
                                onTap: () {
                                  // Navigate to the appropriate page
                                  AppNavigation.push(context, route[j]);
                                },
                              ),
                          ],
                        ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
