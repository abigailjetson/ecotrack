import 'package:cloud_firestore/cloud_firestore.dart';

class UserRoleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> getRole(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['role'];
  }
}
