// import 'dart:io';
// import 'package:chatboat/Servieces/auth_serviece.dart';
// import 'package:chatboat/Servieces/database_service.dart';
// import 'package:chatboat/Servieces/media_serviece.dart';
// import 'package:chatboat/model/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';

// class ChatScreen extends StatefulWidget {
//   final ChatUser otherUser;

//   const ChatScreen({super.key, required this.otherUser});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   ChatUser? currentUser;
//   late AuthService _authService;
//   final TextEditingController _controller = TextEditingController();
//   late DatabaseService _databaseService;
//   final ScrollController _scrollController = ScrollController();
//   late MediaService _mediaService;

//   @override
//   void initState() {
//     super.initState();
//     _authService = AuthService();
//     _databaseService = DatabaseService();
//     _mediaService = MediaService();

//     final user = _authService.user;
//     if (user != null) {
//       currentUser = ChatUser(
//         uid: user.uid,
//         name: user.displayName ?? 'Unknown',
//         email: user.email ?? '',
//         imageURL: user.photoURL ?? '',
//         lastActive: DateTime.now(),
//       );
//     }
//   }

//   void _sendMessage() async {
//     if (_controller.text.trim().isEmpty || currentUser == null) return;

//     final messageText = _controller.text.trim();
//     final chatId = _generateChatId(currentUser!.uid, widget.otherUser.uid);

//     try {
//       await _databaseService.sendChatMessage(
//         chatId,
//         currentUser!.uid,
//         widget.otherUser.uid,
//         messageText,
//         DateTime.now(),
//       );

//       _controller.clear();

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to send message: $e')),
//       );
//     }
//   }

//   String _generateChatId(String uid1, String uid2) {
//     return uid1.hashCode <= uid2.hashCode ? '$uid1-$uid2' : '$uid2-$uid1';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("name"),
//       ),
//       body: _buildUI(),
//     );
//   }

//   Widget _buildUI() {
//     return DashChat(currentUser: currentUser, onSend: onSend, messages: messages);
//   }
// }
