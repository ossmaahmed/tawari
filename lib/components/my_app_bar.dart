// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:tawari/utils/constants.dart";

class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                "assets/images/back.png",
              ),
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Constants.mainColor,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
