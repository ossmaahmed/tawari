import 'package:flutter/material.dart';
import 'package:tawari/service/models/model.dart';
import 'package:tawari/service/widgets/model_card.dart';




class SupermarkeHomeScreen extends StatelessWidget {

  final List<Model> supermarkets = [
    Model(name: 'Arafa market - عرفة ماركت', phoneNumber: '01148987079', address: ' سليمان هدير، أول الفيوم', latitude: 29.313209963205924, longitude:  30.853412380248027 ),
    Model(name: 'سوبر ماركت عرفه اخوان', phoneNumber: '0842355267', address: '، قسم الفيوم، أول الفيوم ',  latitude: 29.32361227885255, longitude: 30.840881100216688),
    Model(name: 'ألبان الطيب فرع الفيوم', phoneNumber: '01023191533', address: ' ش جورج نيوز العبودي، أول الفيوم ',  latitude: 29.31404803513183, longitude: 30.854852400201075),
    Model(name: 'هايبر الابرار - hyper ALabrar', phoneNumber: '01147333642', address: 'سعد زغلول، أول الفيوم ',  latitude: 29.323088446592347, longitude: 30.854614009840073),
    Model(name: 'زاد ماركت - Zad Market', phoneNumber: '01033333176', address: 'جمال عبد الناصر، أول الفيوم',  latitude: 29.319047364564472, longitude: 30.853841533483926),
    Model(name: 'سوبر ماركت يجعلو عامر', phoneNumber: '01019776946', address: 'محمد عبده، ثان الفيوم  ',  latitude: 29.30827036296873, longitude:  30.85358404142849),
    Model(name: 'اسواق شهد', phoneNumber: '01014442625', address: ' قسم الفيوم، أول الفيوم ', latitude: 29.32443543850991, longitude:  30.840022793175404),
    Model(name: 'اسواق غلاب', phoneNumber: '01010731156', address: 'شارع السلخانه، ثان الفيوم ',  latitude: 29.298373384101023, longitude: 30.833801513211288),
    Model(name: 'ماركت الوادى', phoneNumber: '01010731156', address: 'مدخل موقف، مركز سنورس',  latitude: 29.31108630561088, longitude: 30.851047129020454),
    Model(name: 'غلاب حمزاوي ماركت', phoneNumber: '01019599716', address: 'باغوص، ثان الفيوم', latitude: 29.308598565689273, longitude: 30.84283897134919),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(' سوبر ماركت   ',
            style: TextStyle(
              fontSize: 28,
              color:Color(0xFFE86C00),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Transform.flip(
            flipX: true,
            child: Image.asset(
              "assets/images/back.png",
            ),
          ),
        ),
        toolbarHeight: 80,
      ),
      body: ListView.builder(
        itemCount: supermarkets.length,
        itemBuilder: (context, index) {
          return ModelCard(data: supermarkets[index]);
        },
      ),
    );
  }
}