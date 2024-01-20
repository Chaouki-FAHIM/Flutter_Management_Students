abstract class IDAO<T> {
  T getById(int id);
  List<T> getAll();
  void insert(T item);
  void update(T item);
  void delete(int id);
}
