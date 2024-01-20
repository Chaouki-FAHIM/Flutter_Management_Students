import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/model/etudiant.dart';
import 'package:management_homework/widgets/actions/submit_button.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import 'package:management_homework/widgets/toast.dart';
import '../../model/sexe.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/model/etudiant.dart';
import 'package:management_homework/widgets/toast.dart';
import '../../model/sexe.dart';

class StudentDetailPage extends StatefulWidget {
  final Etudiant student;

  StudentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  bool _isDeleting = false;

  Future<void> _delete(BuildContext context) async {
    try {
      setState(() {
        _isDeleting = true;
      });

      await FirebaseFirestore.instance.collection('users').doc(widget.student.id).delete();
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isDeleting = false;
      });

      showToast(message: 'Student deleted');
      Navigator.pop(context);
    } catch (e) {
      showToast(message: e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {

    // test d'exsitance de la session d'authentification
    if (FirebaseAuth.instance.currentUser == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (widget.student == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Etudiant non trouvé")),
        body: const Center(child: Text("Aucun étudiant correspondant trouvé")),
      );
    }

    final sexe = widget.student.sexe == Sexe.HOMME ? "Homme" : "Femmme";

    return Scaffold(
      appBar: const BuildAppBar(title: "Détails d'étudiant"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("ID: ${widget.student.id}", style: const TextStyle(fontSize: 20)),
            Text("Nom: ${widget.student.nom}", style: const TextStyle(fontSize: 18)),
            Text("Prénom: ${widget.student.prenom}",
                style: const TextStyle(fontSize: 18)),
            Text("Matricule: ${widget.student.matricule}",
                style: const TextStyle(fontSize: 18)),
            Text("Année scolaire: ${widget.student.anneeScolaire}",
                style: const TextStyle(fontSize: 18)),
            Text("Sexe: ${sexe}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${widget.student.email}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Center(
              child: SubmitButton(text: 'Delete', onPressed: () => _delete(context), processAction: _isDeleting, icon: Icons.delete_forever),
            )
          ],
        ),
      ),
    );
  }
}
