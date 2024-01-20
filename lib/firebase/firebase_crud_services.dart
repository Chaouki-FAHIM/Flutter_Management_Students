import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:management_homework/firebase/firebase_auth_services.dart';
import 'package:management_homework/widgets/toast.dart';

class FirebaseCRUDService {

  final firseStore = FirebaseFirestore.instance;

  Future <User?> createUser(var modelItem) async {

    final FirebaseAuthService auth = FirebaseAuthService();

    try {
      User? user = await auth.signUpWithEmailAndPassword(modelItem.email,modelItem.password);

      if (user!= null) {
        await firseStore.collection('users').doc('1').set(modelItem);
        showToast(message: 'Student is created');
      }

      return user;
    }
    catch(e) {
      print('error in creating :'+ e.toString());
    }
    return null;
  }

}