import 'package:chatboat/Servieces/auth_serviece.dart';
import 'package:chatboat/model/chat.dart';
import 'package:chatboat/model/chat_message.dart';
import 'package:chatboat/model/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final CollectionReference _userCollection;
  final CollectionReference _chatsCollection;

  DatabaseService()
      : _userCollection = FirebaseFirestore.instance.collection('users'),
        _chatsCollection = FirebaseFirestore.instance.collection('chats');

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    try {
      await _userCollection.doc(userProfile.uid).set(userProfile.toMap());
      print('User profile created in Firestore');
    } catch (e) {
      print('Error saving user profile: $e');
      rethrow;
    }
  }

  Stream<List<UserProfile>> getUserProfiles() {
    final currentUser = _authService.user;
    if (currentUser == null) {
      return Stream.value([]);
    }

    return _userCollection
        .where("uid", isNotEqualTo: currentUser.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            return data != null ? UserProfile.fromMap(data) : null;
          })
          .whereType<UserProfile>()
          .toList();
    });
  }

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    try {
      final docSnapshot = await _chatsCollection.doc(chatId).get();
      return docSnapshot.exists;
    } catch (e) {
      print('Error checking chat existence: $e');
      return false;
    }
  }

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    try {
      await _chatsCollection.doc(chatId).set({
        'id': chatId,
        'participants': [uid1, uid2],
        'createdAt': FieldValue.serverTimestamp(),
        'messages': [],
      });
      print('New chat created with ID: $chatId');
    } catch (e) {
      print('Error creating new chat: $e');
    }
  }

  Future<void> sendChatMessage(
    String chatId,
    String senderId,
    String receiverId,
    String messageText,
    DateTime timestamp,
  ) async {
    try {
      final newMessage = Message(
        senderID: senderId,
        content: messageText,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(timestamp),
      ).toJson();

      await _chatsCollection.doc(chatId).update({
        'messages': FieldValue.arrayUnion([newMessage]),
      });
      print('Message sent successfully to chat ID: $chatId');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  String generateChatId({required String uid1, required String uid2}) {
    return uid1.hashCode <= uid2.hashCode ? '$uid1-$uid2' : '$uid2-$uid1';
  }

  Stream<Chat?> getChatData(String uid1, String uid2) {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);

    return _chatsCollection.doc(chatId).snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        print("Retrieved chat data: $data");
        return Chat.fromJson(data);
      }
      print("No chat data found for chatId: $chatId");
      return null;
    });
  }

  Future<bool> hasMessages(String currentUserUid, String otherUserUid) async {
    final chatId = generateChatId(uid1: currentUserUid, uid2: otherUserUid);
    final messages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .limit(1)
        .get();

    return messages.docs.isNotEmpty;
  }
}
