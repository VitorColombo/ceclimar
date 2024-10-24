
class UserResponse {
  final String uid;
  final String? name;
  final String? email;
  final String? photoURL;

  UserResponse({
    required this.uid,
    this.name,
    this.email,
    this.photoURL,
  });
}