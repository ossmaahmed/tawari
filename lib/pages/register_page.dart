import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:tawari/components/my_button.dart";
import "package:tawari/components/my_text_field.dart";
import "package:tawari/pages/login_page.dart";
import "package:tawari/services/auth_services.dart";
import "package:tawari/utils/constants.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final nationalIDController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthServices authServices = AuthServices();
  bool signingUp = false;

  void signUp() async {
    setState(() {
      signingUp = true;
    });
    await authServices.signUpUser(
      context: context,
      phone: phoneController.text,
      name: nameController.text,
      nationalID: nationalIDController.text,
      password: passwordController.text,
    );
    setState(() {
      signingUp = false;
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
                  height: 5,
                ),
                Center(child: Image.asset("assets/images/logo.png")),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    "إنشاء حساب جديد",
                    style: TextStyle(
                      color: Constants.liteBlackColor,
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: phoneController,
                  label: "رقم الهاتف",
                  hintText: "01xxxxxxxxx",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: nameController,
                  label: "الإسم كاملًا",
                  hintText: "الإسم",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: nationalIDController,
                  label: "الرقم القومي",
                  hintText: "xxxxxxxxxxxxxx",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordController,
                  label: "كلمة السر",
                  hintText: "Pa\$\$w0rd",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                signingUp
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
                        content: "إنشاء حساب",
                        onTab: () => {signUp()},
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "هل لديك حساب؟",
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
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            color: Constants.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
