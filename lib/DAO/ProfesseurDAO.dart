import 'IDAO.dart';
import '../model/professeur.dart';

class ProfesseurDAO implements IDAO<Professeur> {
  List<Professeur> _professeurs = [];

  @override
  Professeur getById(int id) {
    return _professeurs.firstWhere((professeur) => professeur.id == id);
  }

  @override
  List<Professeur> getAll() {
    return _professeurs;
  }

  @override
  void insert(Professeur professeur) {
    _professeurs.add(professeur);
  }

  @override
  void update(Professeur professeur) {
    // Logique de mise à jour à implémenter si nécessaire
  }

  @override
  void delete(int id) {
    _professeurs.removeWhere((professeur) => professeur.id == id);
  }
}
