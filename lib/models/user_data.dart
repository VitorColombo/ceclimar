
class UserResponse {
  final String uid;
  final String? name;
  final String? email;
  final String? photoURL;
  final String role;

  UserResponse({
    required this.uid,
    this.name,
    this.email,
    this.photoURL,
    required this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoURL: json['photoURL'] ?? '',
      role: json['role'] ?? '',
    );
  }
}