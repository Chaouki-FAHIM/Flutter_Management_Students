import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/presentation/signin.dart';
import 'package:management_homework/presentation/signup.dart';
import 'presentation/home.dart';
import 'presentation/student/create.dart';
import 'presentation/professor/create.dart';
import 'model/professeur.dart';
import 'model/etudiant.dart';
import 'model/sexe.dart';


List<Professeur> professeurs = [];
List<Etudiant> students = [];

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyBmkTG6UqYCIeJpB1kqrkkITNRbQeX4YCQ", appId: "1:139603027223:web:55b2d02e9ba98e374c4352", messagingSenderId: "139603027223", projectId: "managment-homework"));
  else
    await Firebase.initializeApp();
  professeurs = [

  ];
  students = [
  ];

  // Ajout de devoirs pour le test
  // professeurs[0].ajouterDevoir(Devoir(1, "Devoir1", DateTime.now(), DateTime.now().addpro(Duration(days: 7))));
  // professeurs[1].ajouterDevoir(Devoir(2, "Devoir2", DateTime.now(), DateTime.now().add(Duration(days: 14))));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (context) => SignUpPage(),
        '/auth': (context) => SignInPage(),
        '/': (context) => HomePage(),
        '/etudiant/create': (context) => const CreateStudent(),
        '/professor/create': (context) => const CreateProfessor(),
      },
    );
  }
}
