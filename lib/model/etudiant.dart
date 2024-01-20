import 'type_personne.dart';
import 'personne.dart';
import 'sexe.dart';

class Etudiant extends Personne {
  int _anneeScolaire;

  // Constructeur
  Etudiant(String id, String nom, String prenom, String matricule, Sexe sexe,
      this._anneeScolaire)
      : super(id, nom, prenom, matricule, TypePersonne.ETUDIANT, sexe);

  Etudiant.compte(String id, String nom, String prenom, String matricule,
      Sexe sexe, this._anneeScolaire, String username, String motPasse)
      : super(id, nom, prenom, matricule, TypePersonne.ETUDIANT, sexe,
            email: username, motPasse: motPasse);

  Etudiant.fromMap(Map<String, dynamic> map)
      : _anneeScolaire = map['anneeScolaire'] ?? 0, // Supposant que 0 est une valeur par défaut acceptable
        super(
        map['id'] ?? 'default-id',
        map['nom'] ?? 'Nom inconnu',
        map['prénom'] ?? 'Prénom inconnu',
        map['matricule'] ?? '0000',
        TypePersonne.ETUDIANT,
        Sexe.values.firstWhere(
              (e) => e.toString() == 'Sexe.' + (map['sexe'] ?? 'defaultSexe'),
          orElse: () => Sexe.HOMME, // Remplacez par votre valeur par défaut pour Sexe
        ),
        email: map['email'],
        motPasse: map['motPasse'],
      );


  // Getter et Setter pour l'année scolaire
  int get anneeScolaire => _anneeScolaire;
  set anneeScolaire(int value) => _anneeScolaire = value;

  // Méthode pour afficher les détails de l'étudiant
  @override
  void afficherDetails() {
    super.afficherDetails();
    print('Année Scolaire: $_anneeScolaire');
  }
}
