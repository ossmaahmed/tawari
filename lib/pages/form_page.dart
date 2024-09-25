// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, use_build_context_synchronously

import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_icon_snackbar/flutter_icon_snackbar.dart";
import "package:http/http.dart" as http;
import "package:image_picker/image_picker.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:provider/provider.dart";
import "package:record/record.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tawari/components/my_app_bar.dart";

import "package:tawari/components/my_button.dart";
import "package:tawari/components/my_text_field.dart";
import "package:tawari/providers/user_provider.dart";
import "package:tawari/utils/constants.dart";

class FormPage extends StatefulWidget {
  int formNumber;
  String latitude;
  String longitude;
  FormPage({
    super.key,
    required this.formNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  File? _file;
  bool isLoading = false;
  bool isRecording = false;
  late final Record audioRecord;

  @override
  void initState() {
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord;
    super.dispose();
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _file = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickVideoFromCamera() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.camera);
    if (pickedVideo != null) {
      _file = File(pickedVideo.path);
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();

        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      IconSnackBar.show(
        context,
        label: "لا نتمتلك الاذن لاستخدام المايكروفون.",
        snackBarType: SnackBarType.fail,
      );
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      _file = File(path!.split("file://").last);

      setState(() {
        isRecording = false;
      });
    } catch (e) {
      IconSnackBar.show(
        context,
        label: "لا نتمتلك الاذن لاستخدام المايكروفون.",
        snackBarType: SnackBarType.fail,
        direction: DismissDirection.up,
      );
    }
  }

  Future<void> sendRequest(
    title,
    BuildContext context,
  ) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("x-auth-token");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Constants.uri}/emergency'),
    );
    if (_file != null) {
      var stream = http.ByteStream(_file!.openRead());
      var length = await _file!.length();
      var multipartFile = http.MultipartFile(
        'media',
        stream,
        length,
        filename: _file!.path.split('/').last,
      );

      request.files.add(multipartFile);
    }

    request.fields.addAll({
      'title': title,
      'phone': phoneController.text,
      'dispatcher': nameController.text,
      'latitude': widget.latitude,
      'longitude': widget.longitude,
    });
    request.headers.addAll({
      "authorization": "Bearer $token",
    });
    var response = await request.send();
    var res = await http.Response.fromStream(response);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      IconSnackBar.show(
        context,
        label: jsonDecode(res.body)["message"],
        snackBarType: SnackBarType.success,
      );
    } else {
      IconSnackBar.show(
        context,
        label: jsonDecode(res.body)["message"],
        snackBarType: SnackBarType.fail,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    phoneController.text = user.phone;
    nameController.text = user.name;
    String formTitle = "";
    String title = "";
    switch (widget.formNumber) {
      case 1:
        formTitle = "النجدة";
        title = "help";
        break;
      case 2:
        formTitle = "حريق";
        title = "fire";
        break;
      case 3:
        formTitle = "إسعاف";
        title = "ambulance";
        break;
      default:
    }
    return Scaffold(
      body: SafeArea(
        child:
            // isLoading
            //     ? Center(
            //         child: LoadingAnimationWidget.fourRotatingDots(
            //           color: Constants.mainColor,
            //           size: 75,
            //         ),
            //       )
            //     :
            Column(
          children: [
            MyAppBar(title: formTitle),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 30),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "املأ هذه البيانات",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "وسيتم الاستجابة لطلبك في اسرع وقت",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyTextField(
                      controller: phoneController,
                      hintText: "01xxxxxxxxx",
                      obscureText: false,
                      label: "رقم الهاتف",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                      controller: nameController,
                      hintText: "الاسم",
                      obscureText: false,
                      label: "الاسم كاملًا",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اختياري",
                            style: TextStyle(
                                color: Constants.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 65,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Constants.greyColor.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isRecording
                                        ? stopRecording()
                                        : startRecording();
                                  },
                                  child: isRecording
                                      ? Icon(
                                          Icons.mic_none,
                                          size: 33,
                                          color: Constants.mainColor,
                                        )
                                      : Icon(
                                          Icons.mic_off_outlined,
                                          size: 33,
                                          color: Constants.mainColor,
                                        ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pickImageFromCamera();
                                  },
                                  child: Image.asset(
                                    "assets/images/image.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pickVideoFromCamera();
                                  },
                                  child: Image.asset(
                                    "assets/images/video.png",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoading
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
                            content: "تقديم الطلب",
                            onTab: () {
                              sendRequest(
                                title,
                                context,
                              );
                            },
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
