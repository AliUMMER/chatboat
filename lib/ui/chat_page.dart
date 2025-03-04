import 'dart:io';
import 'package:chatboat/Servieces/auth_serviece.dart';
import 'package:chatboat/Servieces/database_service.dart';
import 'package:chatboat/Servieces/media_serviece.dart';
import 'package:chatboat/model/chat.dart';
import 'package:chatboat/model/chat_message.dart';
import 'package:chatboat/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dash_chat_2/dash_chat_2.dart' as dash_chat;
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final ChatUser otherUser;

  const ChatPage({super.key, required this.otherUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser? currentUser;
  late AuthService _authService;
  late DatabaseService _databaseService;
  late MediaService _mediaService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _databaseService = DatabaseService();
    _mediaService = MediaService();

    if (_authService.user != null) {
      currentUser = ChatUser(
        uid: _authService.user!.uid,
        name: _authService.user!.displayName ?? "Unknown",
        email: _authService.user!.email ?? "",
        imageURL: _authService.user!.photoURL ?? "",
        lastActive: DateTime.now(),
      );
    } else {
      debugPrint("⚠️ AuthService user is null!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff36B8B8),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.otherUser.imageURL),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(widget.otherUser.name)),
            const Icon(Icons.call, color: Colors.white),
            const SizedBox(width: 20),
            const Icon(Icons.video_call, color: Colors.white),
          ],
        ),
      ),
      body: currentUser != null
          ? Column(
              children: [
                Expanded(child: _buildUI()),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildUI() {
    return StreamBuilder<Chat?>(
      stream:
          _databaseService.getChatData(currentUser!.uid, widget.otherUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No chat data available.'));
        }

        Chat? chat = snapshot.data;
        List<dash_chat.ChatMessage> messages =
            _generateChatMessageList(chat!.messages);

        return dash_chat.DashChat(
          messageOptions: const dash_chat.MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: dash_chat.InputOptions(
            alwaysShowSend: true,
            trailing: [_mediaMessageButton()],
          ),
          currentUser: dash_chat.ChatUser(
            id: currentUser!.uid,
            firstName: currentUser!.name,
            profileImage: currentUser!.imageURL,
          ),
          onSend: _sendMessage,
          messages: messages,
        );
      },
    );
  }

  Future<void> _sendMessage(dash_chat.ChatMessage chatMessage) async {
    if (currentUser == null || chatMessage.text.isEmpty) return;

    String chatId = _databaseService.generateChatId(
      uid1: currentUser!.uid,
      uid2: widget.otherUser.uid,
    );

    Message message = Message(
      senderID: currentUser!.uid,
      content: chatMessage.text,
      messageType: MessageType.Text,
      sentAt: Timestamp.fromDate(chatMessage.createdAt),
    );

    await _databaseService.sendChatMessage(
      chatId,
      currentUser!.uid,
      widget.otherUser.uid,
      chatMessage.text,
      chatMessage.createdAt,
    );
  }

  Future<void> _sendMediaMessage(String imageUrl) async {
    if (currentUser == null) return;

    String chatId = _databaseService.generateChatId(
      uid1: currentUser!.uid,
      uid2: widget.otherUser.uid,
    );

    Message message = Message(
      senderID: currentUser!.uid,
      content: imageUrl,
      messageType: MessageType.Image,
      sentAt: Timestamp.now(),
    );

    await _databaseService.sendChatMessage(
      chatId,
      currentUser!.uid,
      widget.otherUser.uid,
      imageUrl,
      DateTime.now(),
    );
  }

  Future<String?> _uploadImageToStorage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child("chat_images/$fileName.jpg");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Widget _mediaMessageButton() {
    return IconButton(
      icon: const Icon(Icons.image),
      onPressed: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          String? imageUrl = await _uploadImageToStorage(file);
          if (imageUrl != null) {
            _sendMediaMessage(imageUrl);
          }
        }
      },
    );
  }

  List<dash_chat.ChatMessage> _generateChatMessageList(List<Message> messages) {
    return messages.map((m) {
      bool isImageMessage = m.messageType == MessageType.Image;

      return dash_chat.ChatMessage(
        user: m.senderID == currentUser!.uid
            ? dash_chat.ChatUser(
                id: currentUser!.uid,
                firstName: currentUser!.name,
                profileImage: currentUser!.imageURL,
              )
            : dash_chat.ChatUser(
                id: widget.otherUser.uid,
                firstName: widget.otherUser.name,
                profileImage: widget.otherUser.imageURL,
              ),
        text: isImageMessage ? "" : (m.content ?? ""),
        medias: isImageMessage
            ? [
                dash_chat.ChatMedia(
                  url: m.content!,
                  fileName: "Image",
                  type: dash_chat.MediaType.image,
                )
              ]
            : [],
        createdAt: m.sentAt?.toDate() ?? DateTime.now(),
      );
    }).toList();
  }
}
