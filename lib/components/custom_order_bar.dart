import 'package:flutter/material.dart';

class CustomOrderBar extends StatefulWidget {
  const CustomOrderBar({super.key, required this.controller});

  final PageController controller;

  @override
  State<CustomOrderBar> createState() => _CustomOrderBarState();
}

class _CustomOrderBarState extends State<CustomOrderBar> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      id = 0;
                    },
                  );
                  widget.controller.jumpToPage(0);
                },
                child: Text(
                  'Current',
                  style: TextStyle(
                    color: id == 0 ? const Color(0xffE78125) : Colors.grey,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.005,
                color: id == 0 ? const Color(0xffE78125) : Colors.grey,
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    id = 1;
                  });
                  widget.controller.jumpToPage(1);
                },
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: id == 1 ? const Color(0xffE78125) : Colors.grey,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.005,
                color: id == 1 ? const Color(0xffE78125) : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
