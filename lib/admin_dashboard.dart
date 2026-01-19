import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<void> updateStatus(String id, String newStatus) async {
    await FirebaseDatabase.instance.ref('activities/$id').update({
      'status': newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('activities').onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final raw = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          // Filter pending activities
          final pending =
              raw.entries
                  .where((entry) => entry.value['status'] == 'pending')
                  .toList()
                ..sort((a, b) {
                  final aTime = a.value['timestamp'] ?? 0;
                  final bTime = b.value['timestamp'] ?? 0;
                  return bTime.compareTo(aTime);
                });

          if (pending.isEmpty) {
            return const Center(
              child: Text(
                'No pending activities',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pending.length,
            itemBuilder: (context, index) {
              final entry = pending[index];
              final id = entry.key;
              final data = entry.value as Map<dynamic, dynamic>;

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(data['type'] ?? 'Unknown'),
                  subtitle: Text('${data['amount']} • ${data['description']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => updateStatus(id, 'approved'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => updateStatus(id, 'rejected'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
