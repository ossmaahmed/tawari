import 'package:flutter/material.dart';
import 'package:tawari/service/models/model.dart';
import 'package:tawari/service/widgets/model_card.dart';




class HospitalHomeScreen extends StatelessWidget {

  final List<Model> hospitals = [
    Model(name: 'مستشفى الفيوم العام', phoneNumber: '0846337329', address: 'المسلة شارع سعد زغلول ', latitude: 29.316919023457928, longitude: 30.84944624417821),
    Model(name: 'مستشفى الصفوة التخصصي ', phoneNumber:  '01010949999', address: 'السلخانة - ميدان السلخانة ', latitude:29.29709889183884, longitude: 30.83356850184949),
    Model(name: 'مستشفي الندي التخصصي', phoneNumber: '01000803833', address: 'المسلة - النبوي المهندس', latitude:29.312405934215704, longitude: 30.856136640479203),
    Model(name: 'مستشفي الحميات', phoneNumber: '0846357164', address: 'السلخانة - خلف مساكن السلخانة', latitude: 29.296662505612158, longitude: 30.831545984657428),
    Model(name: 'مستشفي السلام التخصصي', phoneNumber: '0842035563', address: 'متفرع من شارع الجمهورية ', latitude: 29.31068887232, longitude: 30.837902728835648),
    Model(name: 'مركز أورام الفيوم', phoneNumber: '01069691045',address: 'امتداد النبوي المهندس خلف الصدر ',latitude: 29.309495262920322, longitude: 30.85935763068514),
    Model(name: 'مستشفى نور الحياة للولادة', phoneNumber: '01023714810', address: 'باغوص - متفرع من شارع الحرية', latitude:29.302827732844037, longitude: 30.855691515342578),
    Model(name: 'مستشفى الفيوم الجامعي', phoneNumber: '0842154761', address: 'تقع داخل جامعة الفيوم ', latitude: 29.32144116060021, longitude: 30.834129946027716),
    Model(name: 'مستشفى جامعة الفيوم الباطني', phoneNumber: '0842360587', address: 'الكيمان - حي الجامعة  ', latitude: 29.3252569035791, longitude:  30.83212881164357),
    Model(name: 'مستشفى الحياة التخصصي ', phoneNumber: '0842140173', address: 'طريق مصر الفيوم - دلة', latitude: 29.323549366177865, longitude: 30.85766193068514),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(' مستشفيات   ',
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
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return ModelCard(data: hospitals[index]);
        },
      ),
    );
  }
}