import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Recycling Points')),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 400,
          color: Colors.grey[300],
          child: Center(child: Text('Map Placeholder')),
        ),
      ),
    );
  }
}
