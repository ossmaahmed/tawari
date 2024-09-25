import "dart:async";

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tawari/pages/home_page.dart";
import "package:tawari/pages/login_page.dart";
import "package:tawari/services/auth_services.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void getUserInfo(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final navigator = Navigator.of(context);
    String? token = prefs.getString("x-auth-token");
    AuthServices authServices = AuthServices();

    if (token == null || token == "") {
      await authServices.getCurrentLocation(context: context);
      Timer(
        const Duration(seconds: 2),
        () {
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        },
      );
    } else {
      Timer(const Duration(seconds: 1), () {
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset("assets/images/splash_logo.png"),
        ),
      ),
    );
  }
}
