// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import "package:tawari/components/my_app_bar.dart";
import "package:tawari/components/service_card.dart";
import "package:tawari/service/pages/gasstation_home.dart";
import "package:tawari/service/pages/hospital_home.dart";
import "package:tawari/service/pages/pharmacies_home.dart";
import "package:tawari/service/pages/restaurant_home.dart";
import "package:tawari/service/pages/supermakert_home.dart";

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          MyAppBar(title: "خدمات الفيوم"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GasStationHomeScreen(),
                            ),
                          );
                        },
                        child: ServiceCard(
                          title: "محطات غاز",
                          image: "assets/images/gas-station.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SupermarkeHomeScreen(),
                            ),
                          );
                        },
                        child: ServiceCard(
                          title: "سوبر ماركت",
                          image: "assets/images/supermarket.png",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PharmaciesHomeScreen(),
                            ),
                          );
                        },
                        child: ServiceCard(
                          title: "صيدليات",
                          image: "assets/images/pharmacy.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalHomeScreen(),
                            ),
                          );
                        },
                        child: ServiceCard(
                          title: "مستشفيات",
                          image: "assets/images/clinic.png",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantHomeScreen(),
                            ),
                          );
                        },
                        child: ServiceCard(
                          title: "مطاعم",
                          image: "assets/images/resturants.png",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
