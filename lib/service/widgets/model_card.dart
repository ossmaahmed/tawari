import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/model.dart';

class ModelCard extends StatelessWidget {
  final Model data;

  ModelCard({required this.data});

  void _openMap() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {

  return Container(
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFE86C00),
        width: 2,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    child: Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                data.name,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                  color:  Color(0xFFE86C00),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.location_on),
                  color: const Color(0xFFE86C00),
                  onPressed: _openMap,
                  iconSize: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('رقم الهاتف: ${data.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 14
                    ),
                    ),
                    const SizedBox(height: 5),
                    Text('العنوان: ${data.address}',
                      style: const TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}


