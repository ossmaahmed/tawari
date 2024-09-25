// ignore_for_file: prefer_typing_uninitialized_variables

import "package:flutter/material.dart";
import "package:tawari/utils/constants.dart";

class MyTextField extends StatelessWidget {
  final controller;
  final String label;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obscureText,
      l,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Constants.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.greyColor.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.greyColor,
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Constants.greyColor.withOpacity(0.75),
              ),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }
}
