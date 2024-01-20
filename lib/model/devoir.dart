class Devoir {
  int _id;
  String _reference;
  DateTime _dateCreation;
  DateTime _dateLimite;

  // Constructeur
  Devoir(this._id, this._reference, this._dateCreation, this._dateLimite);

  // Getter et Setter pour l'id du devoir
  int get id => _id;
  set id(int value) => _id = value;

  // Getter et Setter pour la référence du devoir
  String get reference => _reference;
  set reference(String value) => _reference = value;

  // Getter et Setter pour la date de création du devoir
  DateTime get dateCreation => _dateCreation;
  set dateCreation(DateTime value) => _dateCreation = value;

  // Getter et Setter pour la date limite du devoir
  DateTime get dateLimite => _dateLimite;
  set dateLimite(DateTime value) => _dateLimite = value;
}
