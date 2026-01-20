import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminActivitiesScreen extends StatefulWidget {
  const AdminActivitiesScreen({super.key});

  @override
  State<AdminActivitiesScreen> createState() => _AdminActivitiesScreenState();
}

class _AdminActivitiesScreenState extends State<AdminActivitiesScreen> {
  List<Map<String, dynamic>> allActivities = [];

  @override
  void initState() {
    super.initState();
    fetchAllActivities();
  }

  Future<void> fetchAllActivities() async {
    final ref = FirebaseDatabase.instance.ref('activities');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final data = Map<dynamic, dynamic>.from(snapshot.value as Map);

      setState(() {
        allActivities = data.entries
            .map((e) => Map<String, dynamic>.from(e.value))
            .toList();
      });
    }
  }

  String formatTimestamp(dynamic timestamp) {
    if (timestamp is int) {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
    return timestamp?.toString() ?? 'No timestamp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Activities")),
      body: allActivities.isEmpty
          ? const Center(child: Text("No activities found"))
          : ListView.builder(
              itemCount: allActivities.length,
              itemBuilder: (context, index) {
                final activity = allActivities[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(activity['type'] ?? 'No type'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ${activity['amount'] ?? 'N/A'}'),
                        Text('Status: ${activity['status'] ?? 'N/A'}'),
                        Text('User ID: ${activity['userId'] ?? 'Unknown'}'),
                        Text('Date: ${formatTimestamp(activity['timestamp'])}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
