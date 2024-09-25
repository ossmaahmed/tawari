// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:tawari/utils/constants.dart";

class MyCard extends StatelessWidget {
  String image;
  String title;
  MyCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var opacity = 0.5;
    var xOffset = 0.0;
    var yOffset = 6.0;
    var blurRadius = 3.0;
    var spreadRadius = 0.0;
    return Expanded(child: Container(
      width: 120,
      height: 140,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 42, horizontal: 22),
      decoration: BoxDecoration(
        color: Constants.mainColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Constants.greyColor.withOpacity(opacity),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: Offset(
              xOffset,
              yOffset,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            height: 95,
          ),
          Text(
            title,
            style: TextStyle(
              color: Constants.whiteColor,
              fontSize: 20,
            ),
          )
        ],
      ),
    ));
  }
}
