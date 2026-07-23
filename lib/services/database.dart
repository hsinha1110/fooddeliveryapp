import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection("users").doc(userCredential.user!.uid).set({
      "uid": userCredential.user!.uid,
      "name": name,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> addOrder({
    required String foodName,
    required String foodImage,
    required double total,
    required int quantity,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        print("User is null");
        return;
      }

      // User ki details le lo
      final userDoc = await _firestore.collection("users").doc(user.uid).get();

      final docRef = await _firestore.collection("Orders").add({
        "foodName": foodName,
        "foodImage": foodImage,
        "quantity": quantity,
        "total": total,
        "status": "Pending",
        "userId": user.uid,
        "userName": userDoc.data()?["name"],
        "userEmail": userDoc.data()?["email"],
        "createdAt": FieldValue.serverTimestamp(),
      });

      print("Order ID: ${docRef.id}");
    } catch (e) {
      print("Firestore Error: $e");
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
