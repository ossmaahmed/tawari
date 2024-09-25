import 'package:flutter/material.dart';
import 'package:tawari/service/models/model.dart';
import 'package:tawari/service/widgets/model_card.dart';





class GasStationHomeScreen extends StatelessWidget {

  final List<Model> gasStations = [
    Model(name: 'محطة وقود غازتك', phoneNumber: '---', address: ' قسم الفيوم، أول الفيوم', latitude: 29.348673831242063, longitude: 30.826601439834793),
    Model(name: 'محطة مصر للبترول و غازتك ', phoneNumber:'---', address:' ، ميدان المفارق، سنهور، مركز سنورس', latitude: 29.43721578475918, longitude: 30.77029651037893),
    Model(name: 'محطة وقود غازتك', phoneNumber: '---', address: '  مركز سنورس، محافظة الفيوم ', latitude: 29.43960774045262, longitude:  30.781282838077633),
    Model(name: 'محطة غازتك العدوة', phoneNumber: '---', address: ' قسم الفيوم، مركز الفيوم', latitude: 29.339097113202758, longitude: 30.858187131968574),
    Model(name: 'بنزينة العشيري', phoneNumber: '---', address: ' جمال عبد الناصر، أول الفيوم', latitude: 29.351067870137626, longitude: 30.860933713893253),
    Model(name: 'محطة وقود طاقة', phoneNumber: '---', address: ' قسم الفيوم، مركز أبشواى', latitude:29.33071674679985, longitude:  30.82110827598544),
    Model(name: 'غاز تك', phoneNumber: '---', address: ' مركز أبشواى، محافظة الفيوم ', latitude: 29.388168278103436, longitude: 30.678286015902263),
    Model(name: 'محطة وطنية تقاطع الفيوم', phoneNumber: '---',address:  'قسم الفيوم، أول الفيوم', latitude: 29.646298327170232, longitude: 30.999636101089415),
    Model(name: 'محطة بنزين التعاون', phoneNumber: '---', address: ' طريق رحيم، منشأة سنورس', latitude: 29.501778798928243, longitude: 30.858187131968574),
    Model(name: 'محطة وقود كفور النيل', phoneNumber: '0842121075', address: 'كفور النيل، محافظة الفيوم', latitude: 29.334308416748915, longitude: 30.870546750629625),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(' محطات غاز   ',
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
        itemCount: gasStations.length,
        itemBuilder: (context, index) {
          return ModelCard(data: gasStations[index]);
        },
      ),
    );
  }
}