import 'package:flutter/material.dart';
import 'package:tawari/service/models/model.dart';
import 'package:tawari/service/widgets/model_card.dart';




class RestaurantHomeScreen extends StatelessWidget {

  final List<Model> restaurants = [
    Model(name: 'Crinkle', phoneNumber: '0842112011', address: 'شارع أحمد شوقي - أمام فيلا، المحافظ', latitude: 29.321324864935004, longitude: 30.840959535808686),
    Model(name: ' مطعم الزاوي للمأكولات', phoneNumber: '01002003038 ', address: ' المسلة، ثان الفيوم ',  latitude: 29.297471454198433, longitude: 30.835181870991068),
    Model(name: 'مطعم باربيكيو', phoneNumber: '01093900500', address: 'لطف الله - سور نادي المحافظة', latitude: 29.318780184538014, longitude: 30.84182560589417),
    Model(name: 'مطعم حضر موت اوزي الفيوم', phoneNumber: '01096181827', address: 'كرستال بالاس الدائرى ', latitude: 29.334998571690324, longitude: 30.820885753576814),
    Model(name: 'مطعم التركي شاورما وبرجر', phoneNumber: '01095859400', address: 'المسله العام، أول الفيوم',  latitude: 29.322573480101905, longitude:  30.85651536886621),
    Model(name: 'مطعم الفيومي الكبابجي', phoneNumber: '01013017457',  address:'الفوال امام مستشفي السلام التخصصي', latitude: 29.313253668050777, longitude: 30.836919080457047 ),
    Model(name: 'مطعم السلطان', phoneNumber: '01009404961', address: 'منشأة الفيوم، ثان الفيوم',  latitude: 29.299272353907472, longitude:  30.834178340819395),
    Model(name: 'مطعم الخديوي', phoneNumber: '0846367262', address: ' بطل السلام، ثان الفيوم' , latitude: 29.30465000905565, longitude: 30.838837598203398),
    Model(name: ' مطعم روزانا', phoneNumber: '01030393273', address: ' ميدان المسلة، أول الفيوم ', latitude: 29.31732808238525, longitude:  30.85350425357107),
    Model(name: 'مطعم بهية', phoneNumber: '01022211615', address: 'جمال عبد الناصر، أول الفيوم ',  latitude: 29.31533098914115, longitude: 30.852082607988358 ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Text(' مطاعم   ',
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
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ModelCard(data: restaurants[index]);
        },
      ),
    );
  }
}