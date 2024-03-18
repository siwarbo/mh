import 'package:firebase_auth/firebase_auth.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart';
//
import '../../../global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get the current user's UID
  String? getCurrentUserUID() {
    try {
      return _auth.currentUser?.uid;
    } catch (e) {
      print('Error getting current user UID: $e');
      return null;
    }
  }

  // Method to get the user's email from Firestore
  Future<String?> getUserEmailFromFirestore(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.get('email');
      } else {
        showToast(message: 'User document does not exist');
        return null;
      }
    } catch (e) {
      showToast(message: 'Error fetching user email: $e');
      return null;
    }
  }

  // Method to get the user's role from Firestore
  


  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  //
  Future<void> pushUserDetailsToFirestore(String email, String role) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        CollectionReference ref = firebaseFirestore.collection('users');
        await ref.doc(user.uid).set({'email': email, 'role': role});
      } else {
        showToast(message: 'User is not logged in.');
      }
    } catch (e) {
      showToast(message: 'An error occurred: $e');
    }
  }
  //
  Future<String?> getUserRoleFromFirestore(String uid) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return snapshot.get('role');
    } else {
      showToast(message: "User document does not exist");
      return null;
    }
  } catch (e) {
    showToast(message: "Error fetching user role: $e");
    return null;
  }
}
//
}
