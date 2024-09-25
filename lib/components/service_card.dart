// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:tawari/utils/constants.dart";

class ServiceCard extends StatelessWidget {
  String title;
  String image;
  ServiceCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 165,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 28,
      ),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.mainColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 110,
          ),
          Text(
            title,
            style: TextStyle(
              color: Constants.mainColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
