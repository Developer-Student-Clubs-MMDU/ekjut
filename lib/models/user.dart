class User {
  final List<dynamic> currentLoc;
  final String email;
  final String name;
  bool isProfileCompleted;
  final String uid;
  final List<dynamic> services;

  User({
    required this.services,
    required this.uid,
    required this.currentLoc,
    required this.email,
    required this.isProfileCompleted,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "currentLoc": currentLoc,
        "email": email,
        "name": name,
        "isProfileCompleted": isProfileCompleted,
        "services": services,
        "uid": uid
      };

  static User fromJson(Map<String, dynamic> json) => User(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      services: json["services"],
      currentLoc: json["currentLoc"],
      isProfileCompleted: json["isProfileCompleted"]);
}

class Try {
  final String name;

  Try({required this.name});
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  static Try fromJson(Map<String, dynamic> json) => Try(name: json["name"]);
}
