import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/sexe.dart';
import '../../main.dart';

class ProfesseurDetailPage extends StatelessWidget {
  final String professeurId;

  const ProfesseurDetailPage({Key? key, required this.professeurId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // test d'exsitance de la session d'authentification
    if (FirebaseAuth.instance.currentUser == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Trouver le professeur par son ID
    final professeur = professeurs.firstWhere((p) => p.id == professeurId);
    final sexe = professeur.sexe == Sexe.HOMME ? "Homme" : "Femmme";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du Professeur"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("ID: ${professeur.id}", style: const TextStyle(fontSize: 20)),
            Text("Nom: ${professeur.nom}",
                style: const TextStyle(fontSize: 18)),
            Text("Prénom: ${professeur.prenom}",
                style: const TextStyle(fontSize: 18)),
            Text("Matière: ${professeur.matiere}",
                style: const TextStyle(fontSize: 18)),
            Text("Matricule: ${professeur.matricule}",
                style: const TextStyle(fontSize: 18)),
            Text("Sexe: ${sexe}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${professeur.email}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  int indexToDelete =
                      professeurs.indexWhere((prof) => prof.id == professeurId);
                  professeurs.removeAt(indexToDelete);
                  Navigator.pushNamed(context, '/');
                  print("Delete professeur ${professeurId}");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Couleur de fond du bouton
                ),
                child: const Text(
                  "Supprimer",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
