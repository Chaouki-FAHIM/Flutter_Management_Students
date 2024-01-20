import 'package:flutter/material.dart';
import '../../model/etudiant.dart';
import '../../presentation/student/display.dart';

class EtudiantTile extends StatelessWidget {
  final Etudiant etudiant;

  const EtudiantTile({Key? key, required this.etudiant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Assurez-vous que le type de 'etudiant.id' est compatible avec ce que StudentDetailPage attend

      },
      child: ListTile(
        leading: const Icon(Icons.school),
        title: Text("${etudiant.nom} ${etudiant.prenom}"),
        // Assurez-vous que 'nom' et 'prenom' sont correctement définis dans l'objet 'etudiant'
      ),
    );
  }
}

