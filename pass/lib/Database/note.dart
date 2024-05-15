class Note {
  int? id;
  String title, password, photo, username, information;
  DateTime time;
  Note({
    this.id,
    required this.title,
    required this.password,
    required this.photo,
    required this.username,
    required this.information,
    required this.time,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'password': password,
      'photo': photo,
      'username': username,
      'information': information,
      'time': time.toString(),
    };
  }
}

class Lock {
  int? id;
  String password;

  Lock({
    this.id,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
    };
  }
}
