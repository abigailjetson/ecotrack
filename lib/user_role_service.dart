import 'package:firebase_database/firebase_database.dart';

class UserRoleService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<String?> getRole(String uid) async {
    final snapshot = await _db.child('users/$uid').get();

    if (!snapshot.exists) return null;

    final data = snapshot.value as Map<dynamic, dynamic>;
    return data['role'] as String?;
  }
}
