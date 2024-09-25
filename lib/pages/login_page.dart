import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:tawari/components/my_button.dart";
import "package:tawari/components/my_text_field.dart";
import "package:tawari/pages/register_page.dart";
import "package:tawari/services/auth_services.dart";
import "package:tawari/utils/constants.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthServices authServices = AuthServices();
  bool signingIn = false;

  void signInUser() async {
    setState(() {
      signingIn = true;
    });
    await authServices.signInUser(
      context: context,
      phone: phoneController.text,
      password: passwordController.text,
    );
    setState(() {
      signingIn = false;
    });
  }

  bool isApiCallProcess = false;

  bool hidePassword = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? username;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(child: Image.asset("assets/images/logo.png")),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    "تسجيل الدخول الآن",
                    style: TextStyle(
                      color: Constants.liteBlackColor,
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: phoneController,
                  label: "رقم الهاتف",
                  hintText: "01xxxxxxxxx",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                  controller: passwordController,
                  label: "كلمة السر",
                  hintText: "Pa\$\$w0rd",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                signingIn
                    ? Container(
                        height: 50,
                        margin: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Constants.mainColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: Constants.whiteColor,
                            size: 38,
                          ),
                        ),
                      )
                    : MyButton(
                        content: "تسجيل الدخول",
                        onTab: () => signInUser(),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ليس لديك حساب؟",
                      style: TextStyle(
                        color: Constants.strongGreyColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "إنشاء حساب",
                        style: TextStyle(
                          color: Constants.mainColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
