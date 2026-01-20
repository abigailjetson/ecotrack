import 'dart:developer';

import 'package:ecotrack/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = credential.user;
      if (user == null) {
        throw Exception('User not found');
      }

      final uid = user.uid;
      log('Logged in UID: $uid');

      final userSnapshot = await FirebaseDatabase.instance
          .ref('users/$uid')
          .get();
      log('User snapshot: ${userSnapshot.value}');

      final roleSnapshot = await FirebaseDatabase.instance
          .ref('users/$uid/role')
          .get();
      log('Role snapshot: ${roleSnapshot.value}');

      final role = roleSnapshot.value as String?;

      if (!mounted) return;

      if (role == 'admin') {
        NotificationService.showSimpleNotification();
        Navigator.pushReplacementNamed(context, '/admin_home');
      } else if (role == 'user') {
        NotificationService.showSimpleNotification();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        log('Role is null or unknown: $role');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unknown role: $role')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoTrack Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset_password_screen');
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: isLoading ? null : login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
