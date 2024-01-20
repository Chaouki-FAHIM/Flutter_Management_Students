import 'package:firebase_auth/firebase_auth.dart';
import 'package:management_homework/widgets/toast.dart';

class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future <User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e) {

      if(e.code == 'email-already-in-use') {
        showToast(message: 'The email adresse is already in use. Chose anther ');
      }
      else {
        showToast(message: 'An eroor is : ${e.code}');
      }

    }
    return null;

  }


  Future <User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e) {

      if(e.code == 'user-not-found' || e.code == 'invalid-credential' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or/and password');
      }
      else {
        showToast(message: 'An eroor is : ${e.code}');
      }

  }
    return null;

  }
}