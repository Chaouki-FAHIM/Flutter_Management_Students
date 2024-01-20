import 'IDAO.dart';
import '../model/etudiant.dart';

class EtudiantDAO implements IDAO<Etudiant> {
  List<Etudiant> _etudiants = [];

  @override
  Etudiant getById(int id) {
    return _etudiants.firstWhere((etudiant) => etudiant.id == id);
  }

  @override
  List<Etudiant> getAll() {
    return _etudiants;
  }

  @override
  void insert(Etudiant etudiant) {
    _etudiants.add(etudiant);
  }

  @override
  void update(Etudiant etudiant) {
    // Logique de mise à jour à implémenter si nécessaire
  }

  @override
  void delete(int id) {
    _etudiants.removeWhere((etudiant) => etudiant.id == id);
  }
}
