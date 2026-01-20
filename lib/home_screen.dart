import 'package:ecotrack/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> userActivities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = FirebaseDatabase.instance.ref('activities'); // ✅ fixed path
    final snapshot = await ref.get();

    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      userActivities = data.entries
          .map((entry) => Map<String, dynamic>.from(entry.value))
          .toList();

      setState(() {});
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoTrack Home'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: userActivities.isEmpty
          ? const Center(child: Text("No activities yet"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: userActivities.length,
              itemBuilder: (context, index) {
                final item = userActivities[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(item['type'] ?? 'Unknown'),
                    subtitle: Text(
                      '${item['amount']} • ${item['description'] ?? ''}',
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          NotificationService.showSimpleNotification();
          Navigator.pushNamed(context, '/add_activity');
        },
      ),
    );
  }
}
