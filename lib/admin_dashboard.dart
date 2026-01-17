import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<void> updateStatus(String id, String newStatus) async {
    await FirebaseFirestore.instance.collection('activities').doc(id).update({
      'status': newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('activities')
            .where('status', isEqualTo: 'pending')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'No pending activities',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final activity = docs[index];
              final data = activity.data() as Map<String, dynamic>;

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
                        onPressed: () => updateStatus(activity.id, 'approved'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => updateStatus(activity.id, 'rejected'),
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
