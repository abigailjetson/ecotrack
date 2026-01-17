import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'add_activity_screen.dart';
import 'map_screen.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(EcoTrackApp());
}

class EcoTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoTrack',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddActivityScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
