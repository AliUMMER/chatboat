// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthServices {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmail(String email, String password) async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         print('This email is already registered. Try logging in.');
//       } else {
//         print('Sign-Up Error: ${e.message}');
//       }
//     }
//   }

//   Future<User?> signInWithEmail(String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return credential.user;
//     } catch (e) {
//       print('Sign-In Error: $e');
//     }
//     return null;
//   }
// }
