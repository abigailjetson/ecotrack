import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {'type': 'Recycled plastic', 'amount': '2kg', 'date': 'Today'},
      {'type': 'Walking', 'amount': '3km', 'date': 'Yesterday'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoTrack Home'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final item = activities[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(item['type']!),
              subtitle: Text('${item['amount']} • ${item['date']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_activity');
        },
      ),
    );
  }
}
