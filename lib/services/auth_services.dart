// ignore_for_file: use_build_context_synchronously

import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_icon_snackbar/flutter_icon_snackbar.dart";
import "package:geolocator/geolocator.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tawari/models/user.dart";
import "package:http/http.dart" as http;
import "package:tawari/pages/home_page.dart";
import "package:tawari/pages/login_page.dart";
import "package:tawari/providers/user_provider.dart";
import "package:tawari/utils/constants.dart";
import "package:tawari/utils/utils.dart";

class AuthServices {
  Future<void> signUpUser({
    required BuildContext context,
    required String phone,
    required String name,
    required String nationalID,
    required String password,
  }) async {
    var position = await getCurrentLocation(context: context);
    String latitude = position["latitude"];
    String longitude = position["longitude"];
    try {
      User user = User(
        id: "",
        phone: phone,
        name: name,
        longitude: longitude,
        latitude: latitude,
        nationalID: nationalID,
        password: password,
        profileImage: "",
        token: "",
      );

      http.Response res = await http.post(
        Uri.parse("${Constants.uri}/auth/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          IconSnackBar.show(
            context,
            label: "تم إنشاء حسابك بنجاك، سجل الدخول الآن.",
            snackBarType: SnackBarType.success,
          );
        },
      );
    } catch (e) {
      IconSnackBar.show(
        context,
        label: "حدث شئٌ خاطئ، تاكد من اتصال الانترنت لديك.",
        snackBarType: SnackBarType.fail,
      );
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    try {
      var position = await getCurrentLocation(context: context);
      String latitude = position["latitude"];
      String longitude = position["longitude"];
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse("${Constants.uri}/auth/login"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(
          {
            "phone": phone,
            "password": password,
            "latitude": latitude,
            "longitude": longitude,
          },
        ),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        },
      );
    } catch (e) {
      IconSnackBar.show(
        context,
        label: "حدث شئٌ خاطئ، تاكد من اتصال الانترنت لديك.",
        snackBarType: SnackBarType.fail,
      );
    }
  }

  Future<bool> getUserInfo({
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      http.Response res = await http.get(
        Uri.parse("${Constants.uri}/user"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200) {
        userProvider.setUser(res.body);
        return false;
      }
      return true;
    } catch (e) {
      IconSnackBar.show(
        context,
        label: "يرجى اعادة تسجيل الدخول.",
        snackBarType: SnackBarType.alert,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
      return true;
    }
  }

  Future<Map> getCurrentLocation({required BuildContext context}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      IconSnackBar.show(
        context,
        label: "يجب عليك تفعيل ميزة تحديد الموقع لتفعيل خدماتنا.",
        snackBarType: SnackBarType.alert,
      );
      return {
        "longitude": "",
        "latitude": "",
      };
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      IconSnackBar.show(
        context,
        label: "برجاء السماح بإستخدام الموقع",
        snackBarType: SnackBarType.alert,
      );
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        IconSnackBar.show(
          context,
          label: "ستتوقف خدماتنا التي تتطلب استخدام الموقع",
          snackBarType: SnackBarType.alert,
        );
        return {
          "longitude": "",
          "latitude": "",
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      IconSnackBar.show(
        context,
        label: "برجاء السماح بإستخدام الموقع",
        snackBarType: SnackBarType.alert,
      );
      return {
        "longitude": "",
        "latitude": "",
      };
    }
    var postion = await Geolocator.getCurrentPosition();
    return {
      "longitude": postion.longitude.toString(),
      "latitude": postion.latitude.toString(),
    };
  }
}
