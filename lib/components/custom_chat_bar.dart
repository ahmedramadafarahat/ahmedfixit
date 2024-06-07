import 'package:flutter/material.dart';

class CustomChatBar extends StatefulWidget {
  const CustomChatBar({super.key, required this.controller});

  final PageController controller;

  @override
  State<CustomChatBar> createState() => _CustomChatBarState();
}

class _CustomChatBarState extends State<CustomChatBar> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      id = 0;
                    },
                  );
                  widget.controller.jumpToPage(0);
                },
                icon: Icon(
                  Icons.chat_outlined,
                  color: id == 0 ? const Color(0xffE78125) : Colors.grey,
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
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      id = 1;
                    },
                  );
                  widget.controller.jumpToPage(1);
                },
                icon: Icon(
                  Icons.call_outlined,
                  color: id == 1 ? const Color(0xffE78125) : Colors.grey,
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
