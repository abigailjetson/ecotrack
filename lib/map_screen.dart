import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Recycling Points')),
      body: Center(
        child: lat == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Location:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Latitude: $lat'),
                  Text('Longitude: $lng'),
                  SizedBox(height: 32),
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(child: Text('Map Placeholder')),
                  ),
                ],
              ),
      ),
    );
  }
}
