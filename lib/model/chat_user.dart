class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  late DateTime lastActive;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.lastActive,
  });

  /// **Convert Firestore document to ChatUser**
  factory ChatUser.fromMap(Map<String, dynamic> data) {
    return ChatUser(
      uid: data["uid"] ?? '',
      name: data["name"] ?? 'Unknown',
      email: data["email"] ?? 'No Email',
      imageURL: data["image"] ?? 'assets/default_profile.png',
      lastActive: (data["last_active"] != null)
          ? data["last_active"].toDate()
          : DateTime.now(),
    );
  }

  /// **Convert ChatUser to Map (for Firestore)**
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "last_active": lastActive,
      "image": imageURL,
    };
  }

  /// **Get last active date as a readable string**
  String lastDayActive() {
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  /// **Check if the user was active in the last 2 hours**
  bool wasRecentlyActive() {
    return DateTime.now().difference(lastActive).inHours < 2;
  }
}
