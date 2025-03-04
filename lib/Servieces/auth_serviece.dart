import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  AuthService() {
    // Initialize the user from the current session if available
    _user = _firebaseAuth.currentUser;

    // Listen for auth state changes
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth Error: ${e.message}');
      return false;
    } catch (e) {
      print('General Error: $e');
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print('Signup Error: $e');
    }
    return false;
  }

  void authStateChangesStreamListener(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user = null;
  }
}
