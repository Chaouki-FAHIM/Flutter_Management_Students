import 'package:flutter/material.dart';
import '../../model/professeur.dart';
import '../../presentation/professor/display.dart';

class ProfesseurTile extends StatelessWidget {
  final Professeur professeur;

  const ProfesseurTile({Key? key, required this.professeur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        // Logique de navigation vers la page de détail du professeur
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfesseurDetailPage(professeurId: professeur.id)),
        );
      },
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text("${professeur.nom} ${professeur.prenom}"),
        subtitle: Text(professeur.matiere),
        // Autres informations peuvent être ajoutées ici
      ),
    ));
  }
}
