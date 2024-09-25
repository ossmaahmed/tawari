// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_icon_snackbar/flutter_icon_snackbar.dart";
import "package:tawari/components/my_app_bar.dart";
import "package:tawari/utils/constants.dart";
import "package:url_launcher/url_launcher_string.dart";

class LocationsPage extends StatefulWidget {
  int locationsNumber;
  LocationsPage({
    super.key,
    required this.locationsNumber,
  });

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

Future<void> openLocation(BuildContext context, latitude, longitude) async {
  String googleUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  await canLaunchUrlString(googleUrl)
      ? await launchUrlString(googleUrl)
      : IconSnackBar.show(
          context,
          label: "لا يمكن استخدام الموقع حاليًا",
          snackBarType: SnackBarType.fail,
        );
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    String title = "";
    switch (widget.locationsNumber) {
      case 1:
        title = "محطات غاز";
        break;
      case 2:
        title = "سوبر ماركت";
        break;
      case 3:
        title = "صيدليات";
        break;
      case 4:
        title = "عيادات";
        break;
      case 5:
        title = "مطاعم";
        break;
      default:
    }
    var opacity = 0.5;
    var blurRadius = 3.0;
    var spreadRadius = 0.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: title,
            ),
           /* GestureDetector(
              onTap: () {
                openLocation(
                  context,
                  29.319497314172192,
                  30.707808400436196,
                );
              },
              child:
            )*/
            Container(
              width: 320,
              height: 120,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 20,),
              decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Constants.greyColor.withOpacity(opacity),
                    spreadRadius: spreadRadius,
                    blurRadius: blurRadius,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
