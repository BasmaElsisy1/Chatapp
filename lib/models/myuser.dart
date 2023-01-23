class myUser {
  String id;
  String firstname;
  String lastname;
  String username;
  String email;

  myUser(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.username});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "email": email
    };
  }

  myUser.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            firstname: json['firstname'],
            lastname: json['lastname'],
            username: json['username'],
            email: json['email']);
}
