import "package:flutter/material.dart";
import "package:tawari/utils/constants.dart";

class MyButton extends StatelessWidget {
  final String content;
  final Function()? onTab;
  const MyButton({super.key, required this.content, this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Constants.mainColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            content,
            style: TextStyle(
              color: Constants.whiteColor,
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }
}
