// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_icon_snackbar/flutter_icon_snackbar.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tawari/components/my_card.dart";
import "package:tawari/pages/form_page.dart";
import "package:tawari/pages/login_page.dart";
import "package:tawari/pages/services_page.dart";

import "package:tawari/providers/user_provider.dart";
import "package:tawari/services/auth_services.dart";
import "package:tawari/utils/constants.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  AuthServices authServices = AuthServices();
  bool signingOut = false;

  void getUserInfo() async {
    isLoading = await authServices.getUserInfo(context: context);
  }

  void openFormPage(formNumber) async {
    var position = await authServices.getCurrentLocation(context: context);
    String latitude = position["latitude"];
    String longitude = position["longitude"];
    if (longitude == "" || latitude == "") {
      IconSnackBar.show(
        context,
        label: "لا تعمل هذه الخدمه بدون استخدام الموقع.",
        snackBarType: SnackBarType.fail,
      );
      return;
    }
    final navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (context) => FormPage(
          formNumber: formNumber,
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }

  void signOut() async {
    setState(() {
      signingOut = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("x-auth-token", "");
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
        IconSnackBar.show(
          context,
          label: "تم تسجيل الخروج بنجاح",
          snackBarType: SnackBarType.success,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
      ),
      body: isLoading
          ? SafeArea(
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Constants.mainColor,
                  size: 75,
                ),
              ),
            )
          : SafeArea(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Constants.mainColor,
                                child: CircleAvatar(
                                  radius: 33,
                                  child: user.profileImage != ""
                                      ? Container(
                                    width: 80,
                                    height: 80,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      user.profileImage,
                                    ),
                                  )
                                      : Image.asset(
                                    "assets/images/profile.png",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    "اهلًا بك معنا يا صديقي",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Image.asset(
                            "assets/images/logo.png",
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      openFormPage(1);
                                    },
                                    child: MyCard(
                                      image: "assets/images/policee.png",
                                      title: "النجدة",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigator.push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const ServicesPage(),
                                        ),
                                      );
                                    },
                                    child: MyCard(
                                      image: "assets/images/servises.png",
                                      title: "خدمات",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      openFormPage(2);
                                    },
                                    child: MyCard(
                                      image: "assets/images/fire.png",
                                      title: "حريق",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      openFormPage(3);
                                    },
                                    child: MyCard(
                                      image: "assets/images/ambulance.png",
                                      title: "اسعاف",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signOut();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(
                          bottom: 32,
                          right: 32,
                        ),
                        decoration: BoxDecoration(
                          color: Constants.mainColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: signingOut
                            ? LoadingAnimationWidget.fourRotatingDots(
                          color: Constants.whiteColor,
                          size: 38,
                        )
                            : Icon(
                          Icons.exit_to_app,
                          size: 38,
                          color: Constants.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ),
    );
  }
}
