import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin_dashboard.dart';
import 'user_dashboard.dart';
import 'notification_service.dart';
import 'firebase_options.dart';
import 'package:ecotrack/add_activity_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  runApp(const EcoTrackApp());
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/admin': (context) => const AdminDashboard(),
        '/user': (context) => UserDashboard(),
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => UserDashboard(),
        '/add': (context) => const AddActivityScreen(),
      },
    );
  }
}
