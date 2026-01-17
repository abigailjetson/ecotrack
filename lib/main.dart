import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'add_activity_screen.dart';
import 'map_screen.dart';
import 'package:ecotrack/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';

// Add these:
import 'admin_dashboard.dart';
import 'user_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EcoTrackApp());
}

class EcoTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),

        '/admin': (context) => AdminDashboard(),
        '/user': (context) => UserDashboard(),
      },
    );
  }
}
