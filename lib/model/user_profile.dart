class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  final String phone;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageURL': imageURL,
      'phone': phone,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageURL: map['imageURL'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
