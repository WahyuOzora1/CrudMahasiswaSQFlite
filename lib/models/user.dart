class User {
  int idUser;
  String username;
  String email;
  String password;

  User({this.username, this.email, this.password});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (idUser != null) {
      //masukin satu" tiap datanya, kalau id nya tidak null baru masukin ke map
      map['idUser'] = idUser;
    }
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.idUser = map['idUser'];
    this.email = map['email'];
    this.username = map['username'];
    this.password = map['password'];
  }
}
