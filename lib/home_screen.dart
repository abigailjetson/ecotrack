import 'package:flutter/material.dart';
import 'notification_service.dart';

class HomeScreen extends StatelessWidget {
  final activities = [
    {'type': 'Recycled plastic', 'amount': '2kg', 'date': 'Today'},
    {'type': 'Walking', 'amount': '3km', 'date': 'Yesterday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EcoTrack')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final item = activities[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(item['type']!),
              subtitle: Text('${item['amount']} • ${item['date']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          NotificationService.showSimpleNotification();
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
