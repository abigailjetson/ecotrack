import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

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
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/all_activities');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('View All Activities'),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('View Recycling Map'),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_activity');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Add Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
