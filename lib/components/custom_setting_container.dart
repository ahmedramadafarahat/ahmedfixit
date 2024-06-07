import 'package:fixit/components/constants.dart';
import 'package:flutter/material.dart';

class CustomSettingContainer extends StatelessWidget {
  const CustomSettingContainer({
    super.key,
    required this.onTap,
    this.icon,
    this.image,
    required this.title,
    this.icon2,
  });
  final VoidCallback onTap;
  final Icon? icon;
  final Image? image;
  final String title;
  final Widget? icon2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          height: 60,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: image,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: icon2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
