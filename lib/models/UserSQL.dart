class UserSQL {
  final String id;
  String userName;
  final String email;
  String androidToken;
  String iosToken;
  String urlProfilePicture;
  final DateTime joinDate;

  UserSQL({
    required this.id,
    this.userName = "",
    required this.email,
    this.androidToken = "",
    this.iosToken = "",
    this.urlProfilePicture = "",
    required this.joinDate,
  });
}
