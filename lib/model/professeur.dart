import 'type_personne.dart';

import 'personne.dart';
import 'devoir.dart';
import 'sexe.dart';

class Professeur extends Personne {
  String _matiere;
  List<Devoir> _listeDevoirs;
  // Constructeur
  Professeur(String id, String nom, String prenom, String matricule, Sexe sexe,
      this._matiere, this._listeDevoirs)
      : super(id, nom, prenom, matricule, TypePersonne.PROFESSEUR, sexe);
  Professeur.compte(
      String id,
      String nom,
      String prenom,
      String matricule,
      Sexe sexe,
      this._matiere,
      this._listeDevoirs,
      String email,
      String motPasse)
      : super(id, nom, prenom, matricule, TypePersonne.PROFESSEUR, sexe,
            email: email, motPasse: motPasse);

  // Getter pour la liste des devoirs
  List<Devoir> get listeDevoirs => _listeDevoirs;
  String get matiere => _matiere;

  // Méthode pour ajouter un devoir à la liste
  void ajouterDevoir(Devoir devoir) {
    _listeDevoirs.add(devoir);
  }

  // Méthode pour afficher les détails du professeur, y compris la liste des devoirs
  @override
  void afficherDetails() {
    super.afficherDetails();
    print('Liste des Devoirs:');
    for (var devoir in _listeDevoirs) {
      print(
          'ID de Devoir: ${devoir.id}, Référence: ${devoir.reference}, Date de Création: ${devoir.dateCreation}, Date Limite: ${devoir.dateLimite}');
    }
  }
}
