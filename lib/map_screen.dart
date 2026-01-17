import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? lat;
  double? lng;
  bool permissionDenied = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    setState(() {
      loading = true;
      permissionDenied = false;
    });

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        permissionDenied = true;
        loading = false;
      });
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Recycling Points')),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : permissionDenied
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Location permission denied',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: getLocation,
                    child: const Text('Retry'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your Location:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Latitude: $lat'),
                  Text('Longitude: $lng'),
                  const SizedBox(height: 32),

                  // Map placeholder card
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(
                      child: Text(
                        'Map Placeholder',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: getLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Recenter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
