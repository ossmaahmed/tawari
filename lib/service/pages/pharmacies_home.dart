import 'package:flutter/material.dart';
import 'package:tawari/service/models/model.dart';
import 'package:tawari/service/widgets/model_card.dart';




class PharmaciesHomeScreen extends StatelessWidget {

  final List<Model> pharmacies = [
    Model(name: 'صيدلية الحكيم ', phoneNumber: '0842040706', address: 'الخليفة المأمون - الحادقة', latitude:29.309365586010504, longitude: 30.84338803068514),
    Model(name: 'صيدلية العزبي ', phoneNumber: '0235317347', address: 'برج اجياد,ش جمال عبدالناصر,المسلة', latitude: 29.313624661695613, longitude:30.85097143068515),
    Model(name: 'صيدلية 19011', phoneNumber: '0226737212', address: 'شارع الحريه بجوار عمر افندي ', latitude: 29.308109022194916, longitude:  30.845264486506927),
    Model(name: 'صيدلية  24 ساعة', phoneNumber: '01030500102', address: 'إبراهيم الدروي - قحافة', latitude: 29.306662390949423, longitude: 30.853286698150498),
    Model(name: 'صيدلية رشدي', phoneNumber: '01069000459', address: 'برج الصحابة - شارع الحرية- باغوص', latitude: 29.302003173315747, longitude:  30.85654788835643),
    Model(name: 'صيدلية وصفة', phoneNumber: '01021630630', address: 'الفيوم - ميدان المحمدية', latitude:29.30747026786113, longitude: 30.844100240479207),
    Model(name: 'صيدلية چيمي', phoneNumber: '01004009713', address: 'ميدان المسلة - المسلة', latitude: 29.31558315224305, longitude:  30.853151346027715),
    Model(name: 'صيدلية صحتي ', phoneNumber: '0842112689', address: 'برج التجاريين - أمام موقف مصر', latitude: 29.310553651249876, longitude:  30.848580784657447),
    Model(name: 'صيدلية الجبيلي', phoneNumber: '01068309213', address: 'منشاة عبد الله,الصفوه ', latitude:29.329976996089183, longitude: 30.841721371164354),
    Model(name: 'صيدلية 24 - فرع وسط البلد', phoneNumber: '01062926520', address: 'عرفة, الفيوم - السواقي ', latitude: 29.30873289891743, longitude:30.842667498150497),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(' صيدليات   ',
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
        itemCount: pharmacies.length,
        itemBuilder: (context, index) {
          return ModelCard(data: pharmacies[index]);
        },
      ),
    );
  }
}