import 'package:ecotrack/admin_activities.dart';
import 'package:ecotrack/firebase_options.dart';
import 'package:ecotrack/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'home_screen.dart';
import 'admin_home_screen.dart';
import 'add_activity_screen.dart';
import 'map_screen.dart';
import 'password_reset_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: androidInit,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();

  runApp(const EcoTrackApp());
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoTrack',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin_home': (context) => const AdminHomeScreen(),
        '/all_activities': (context) => const AdminActivitiesScreen(),
        '/add_activity': (context) => const AddActivityScreen(),
        '/map': (context) => const MapScreen(),
        '/reset_password_screen': (context) => const PasswordResetScreen(),
      },
    );
  }
}
