import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Activities')),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('activities').onValue,
        builder: (context, snapshot) {
          // 1. Handle loading or empty database
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(
              child: Text(
                'No activities yet.\nTap + to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // 2. Extract raw data safely
          final raw = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          // 3. Filter activities belonging to this user
          final userActivities =
              raw.entries
                  .where((entry) => entry.value['userId'] == user?.uid)
                  .toList()
                ..sort((a, b) {
                  final aTime = a.value['timestamp'] ?? 0;
                  final bTime = b.value['timestamp'] ?? 0;
                  return bTime.compareTo(aTime);
                });

          // 4. If user has no activities
          if (userActivities.isEmpty) {
            return const Center(
              child: Text(
                'No activities yet.\nTap + to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // 5. Render list
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: userActivities.length,
            itemBuilder: (context, index) {
              final entry = userActivities[index];
              final data = entry.value as Map<dynamic, dynamic>;

              final status = data['status'] ?? 'pending';
              Color statusColor;

              switch (status) {
                case 'approved':
                  statusColor = Colors.green;
                  break;
                case 'rejected':
                  statusColor = Colors.red;
                  break;
                default:
                  statusColor = Colors.orange;
              }

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(data['type'] ?? 'Unknown'),
                  subtitle: Text('${data['amount']} • ${data['description']}'),
                  trailing: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
