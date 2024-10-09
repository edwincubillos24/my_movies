class Movie {
  String _id;
  String _name;
  String _actor;
  int _duration;
  double _rating;
  bool _isActionGenre;
  bool _isAdventureGenre;
  bool _isDramaGenre;
  bool _isFantasyGenre;
  bool _isFictionGenre;
  bool _isRomanceGenre;
  bool _isSuspenseGenre;
  bool _isTerrorGenre;
  String _urlPicture;

  Map<String, dynamic> toJson() => {
    "id": _id,
    "name": _name,
    "actor": _actor,
    "duration": _duration,
    "rating": _rating,
    "isActionGenre": _isActionGenre,
    "isAdventureGenre": _isAdventureGenre,
    "isDramaGenre": _isDramaGenre,
    "isFantasyGenre": _isFantasyGenre,
    "isFictionGenre": _isFictionGenre,
    "isRomanceGenre": _isRomanceGenre,
    "isSuspenseGenre": _isSuspenseGenre,
    "isTerrorGenre": _isTerrorGenre,
    "urlPicture": _urlPicture,
  };

  Movie(
      this._id,
      this._name,
      this._actor,
      this._duration,
      this._rating,
      this._isActionGenre,
      this._isAdventureGenre,
      this._isDramaGenre,
      this._isFantasyGenre,
      this._isFictionGenre,
      this._isRomanceGenre,
      this._isSuspenseGenre,
      this._isTerrorGenre,
      this._urlPicture);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get urlPicture => _urlPicture;

  set urlPicture(String value) {
    _urlPicture = value;
  }

  bool get isTerrorGenre => _isTerrorGenre;

  set isTerrorGenre(bool value) {
    _isTerrorGenre = value;
  }

  bool get isSuspenseGenre => _isSuspenseGenre;

  set isSuspenseGenre(bool value) {
    _isSuspenseGenre = value;
  }

  bool get isRomanceGenre => _isRomanceGenre;

  set isRomanceGenre(bool value) {
    _isRomanceGenre = value;
  }

  bool get isFictionGenre => _isFictionGenre;

  set isFictionGenre(bool value) {
    _isFictionGenre = value;
  }

  bool get isFantasyGenre => _isFantasyGenre;

  set isFantasyGenre(bool value) {
    _isFantasyGenre = value;
  }

  bool get isDramaGenre => _isDramaGenre;

  set isDramaGenre(bool value) {
    _isDramaGenre = value;
  }

  bool get isAdventureGenre => _isAdventureGenre;

  set isAdventureGenre(bool value) {
    _isAdventureGenre = value;
  }

  bool get isActionGenre => _isActionGenre;

  set isActionGenre(bool value) {
    _isActionGenre = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  int get duration => _duration;

  set duration(int value) {
    _duration = value;
  }

  String get actor => _actor;

  set actor(String value) {
    _actor = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
