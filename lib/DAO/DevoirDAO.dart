import 'IDAO.dart';
import '../model/devoir.dart';

class DevoirDAO implements IDAO<Devoir> {
  List<Devoir> _devoirs = [];

  @override
  Devoir getById(int id) {
    return _devoirs.firstWhere((devoir) => devoir.id == id);
  }

  @override
  List<Devoir> getAll() {
    return _devoirs;
  }

  @override
  void insert(Devoir item) {
    _devoirs.add(item);
  }

  @override
  void update(Devoir item) {
    // Logique de mise à jour à implémenter si nécessaire
  }

  @override
  void delete(int id) {
    _devoirs.removeWhere((devoir) => devoir.id == id);
  }
}
