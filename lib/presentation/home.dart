import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/model/etudiant.dart';
import 'package:management_homework/presentation/student/display.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import '../main.dart';
import '../widgets/cards/professeur.dart';
import '../widgets/cards/etudiant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Etudiant> students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      List<Etudiant> tempList = [];
      for (var doc in querySnapshot.docs) {
        tempList.add(Etudiant.fromMap(doc.data() as Map<String, dynamic>));
      }
      setState(() {
        students = tempList;
      });
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {

    // test d'exsitance de la session d'authentification
    if (FirebaseAuth.instance.currentUser == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    _fetchStudents();
    return Scaffold(
      appBar: const BuildAppBar(title: 'Acceuil'),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profil'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Etudiants'),
                onTap: () {
                  Navigator.pushNamed(context, '/etudiant/create');
                },
              ),
              ListTile(
                leading: const Icon(Icons.cast_for_education),
                title: const Text('Professeurs'),
                onTap: () {
                  Navigator.pushNamed(context, '/professor/create');
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Déconnexion'),
                onTap: () {
                  //sessionManager.currentUser = null;
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/auth');
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Assurez-vous que le type de 'etudiant.id' est compatible avec ce que StudentDetailPage attend
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StudentDetailPage(student: students[index])),
              );
            },
            child: ListTile(
            leading: const Icon(Icons.school),
              title: Text(students[index].nom + ' ' + students[index].prenom),
            ),
          );
        },
      ),
    );
  }
}
