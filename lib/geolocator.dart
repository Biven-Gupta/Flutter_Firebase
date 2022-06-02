import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeG extends StatefulWidget {
  const HomeG({Key? key}) : super(key: key);

  @override
  State<HomeG> createState() => _HomeGState();
}

class _HomeGState extends State<HomeG> {
  void getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Permission not given');
      Geolocator.requestPermission();
    } else {
      Position current = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(current.longitude.toString());
      print(current.latitude.toString());

      // Distance between two points
      //Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              getPosition();
            },
            child: const Text('Get Location'),
          ),
        ),
      ),
    );
  }
}
