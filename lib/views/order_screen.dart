import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/components/constants.dart';
import 'package:fixit/components/custom_current_card.dart';
import 'package:fixit/components/custom_order_bar.dart';
import 'package:fixit/components/custom_previous_card.dart';
import 'package:fixit/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:fixit/main.dart'; // Assuming you have a shared preference instance in main.dart

import '../src/data/app_size.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  Stream<List<OrderModel>> _streamOrders() {
    String userId = sharedPrefrence
        .getString('userId')!; // Replace with actual user ID fetch logic

    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Future<void> _deleteOrder(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(docId).delete();
    } catch (e) {
      // Handle error
      print('Error deleting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image(
              height: PhoneSize.phoneHeight(context) * 0.2,
              image: const AssetImage(
                'assets/images/order.png',
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                border: const Border(
                  top: BorderSide(color: Color(0xff1B3A56), width: 4),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CustomOrderBar(
                    controller: controller,
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      children: [
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: kPrimaryColor,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Processes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'ReadexPro',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'ReadexPro',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Status',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'ReadexPro',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'ReadexPro',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<List<OrderModel>>(
                              stream: _streamOrders(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(child: Text('No Orders Found'));
                                }
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  width: 500,
                                  height:
                                      .6 * MediaQuery.sizeOf(context).height,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final order = snapshot.data![index];
                                      return CustomCurrentCard(
                                        service: order.name,
                                        date: order.date,
                                        colorOfCircleAvatar:
                                            order.status == "accepted"
                                                ? Colors.green
                                                : Colors.yellow,
                                        status: order.status,
                                        onPressed: () => _deleteOrder(
                                            order.id), // Add delete logic
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        ListView(
                          children: const [
                            CustomPreviousCard(
                              image: 'assets/images/Don.jpg',
                              name: 'Ahmed Okal',
                              time: '6 Months',
                              service: 'Carpentry Service',
                            ),
                            CustomPreviousCard(
                              image: 'assets/images/Don.jpg',
                              name: 'Ahmed Okal',
                              time: '6 Months',
                              service: 'Carpentry Service',
                            ),
                            CustomPreviousCard(
                              image: 'assets/images/Don.jpg',
                              name: 'Ahmed Okal',
                              time: '6 Months',
                              service: 'Carpentry Service',
                            ),
                            CustomPreviousCard(
                              image: 'assets/images/Don.jpg',
                              name: 'Ahmed Okal',
                              time: '6 Months',
                              service: 'Carpentry Service',
                            ),
                            CustomPreviousCard(
                              image: 'assets/images/Don.jpg',
                              name: 'Ahmed Okal',
                              time: '6 Months',
                              service: 'Carpentry Service',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
