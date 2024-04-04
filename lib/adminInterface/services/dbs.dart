import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alh/adminInterface/models/role_model.dart';

class Db {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Role>> getRole() {
    return _firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Role.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Role>> getPendingRole() {
    return _firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Role.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateRole(
    Role role,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: role.email)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.first.reference.update({field: newValue}));
  }
}
