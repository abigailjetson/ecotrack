import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecotrack/user_role_service.dart';
import 'admin_dashboard.dart';
import 'user_dashboard.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              const Text(
                'EcoTrack',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  try {
                    // 1. Sign in
                    UserCredential credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                    final user = FirebaseAuth.instance.currentUser;
                    print("USER UID: ${user?.uid}");

                    // 2. Fetch role
                    final role = await UserRoleService().getRole(user!.uid);
                    print("USER ROLE: $role");

                    // 3. Navigate based on role
                    if (role == 'admin') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => AdminDashboard()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => UserDashboard()),
                      );
                    }
                  } catch (e) {
                    print("Login error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
