import 'package:chatboat/ui/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:chatboat/model/chat_user.dart';
import 'package:dash_chat_2/dash_chat_2.dart' as dash_chat;

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<ChatUser> contacts = [
    ChatUser(
      uid: '1',
      name: 'Devesh Ojha',
      email: 'devesh@example.com',
      imageURL: 'assets/dp 1.png',
      lastActive: DateTime.now(),
    ),
    ChatUser(
      uid: '2',
      name: 'Fathima',
      email: 'fathima@example.com',
      imageURL: 'assets/dp 2.png',
      lastActive: DateTime.now(),
    ),
    ChatUser(
      uid: '3',
      name: 'Sachin',
      email: 'sachin@example.com',
      imageURL: 'assets/dp 3.png',
      lastActive: DateTime.now(),
    ),
    ChatUser(
      uid: '4',
      name: 'Mohit Tyagi',
      email: 'mohit@example.com',
      imageURL: 'assets/dp 4.png',
      lastActive: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff36B8B8),
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: const TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(text: 'Chats'),
            Tab(text: 'Calls'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final user = contacts[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(user.imageURL)),
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    otherUser: user,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff36B8B8),
        onPressed: () {},
        child: const Icon(Icons.group, color: Colors.white),
      ),
    );
  }
}
