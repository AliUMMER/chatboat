import 'package:chatboat/Servieces/database_service.dart';
import 'package:chatboat/model/chat_user.dart';
import 'package:chatboat/ui/chat_page.dart';
import 'package:chatboat/ui/chat_screen.dart';
import 'package:chatboat/ui/contacts_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:chatboat/model/user_profile.dart';
import 'package:dash_chat_2/dash_chat_2.dart' as dash_chat;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<ChatUser> contacts = [
  //   // ChatUser(
  //   //   uid: '1',
  //   //   name: 'Devesh Ojha',
  //   //   email: 'devesh@example.com',
  //   //   imageURL: 'assets/dp 1.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '2',
  //   //   name: 'Fathima',
  //   //   email: 'fathima@example.com',
  //   //   imageURL: 'assets/dp 2.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '3',
  //   //   name: 'Sachin',
  //   //   email: 'sachin@example.com',
  //   //   imageURL: 'assets/dp 3.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '4',
  //   //   name: 'Mohit Tyagi',
  //   //   email: 'mohit@example.com',
  //   //   imageURL: 'assets/dp 4.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '5',
  //   //   name: 'Adnan',
  //   //   email: 'adnan@example.com',
  //   //   imageURL: 'assets/adnan.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '6',
  //   //   name: 'Farhan',
  //   //   email: 'farhan@example.com',
  //   //   imageURL: 'assets/farhan.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '7',
  //   //   name: 'Kasim',
  //   //   email: 'kasim@example.com',
  //   //   imageURL: 'assets/kasim.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '8',
  //   //   name: 'Naseera',
  //   //   email: 'naseera@example.com',
  //   //   imageURL: 'assets/naseera.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  //   // ChatUser(
  //   //   uid: '9',
  //   //   name: 'Shafeel',
  //   //   email: 'shafeel@example.com',
  //   //   imageURL: 'assets/shafeel.png',
  //   //   lastActive: DateTime.now(),
  //   // ),
  // ];

  final GetIt _getIt = GetIt.instance;
  late FirebaseAuth _authService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<FirebaseAuth>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  Future<void> _handleChat(UserProfile userProfile) async {
    final currentUserUid = _authService.currentUser?.uid;
    final otherUserUid = userProfile.uid;

    if (currentUserUid != null && otherUserUid.isNotEmpty) {
      final chatExists = await _databaseService.checkChatExists(
        currentUserUid,
        otherUserUid,
      );

      if (!chatExists) {
        await _databaseService.createNewChat(
          currentUserUid,
          otherUserUid,
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            otherUser: ChatUser(
              uid: userProfile.uid, // Ensure this exists
              name: userProfile.name,
              email: userProfile.email,
              imageURL: userProfile.imageURL,
              lastActive: DateTime.now(),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff36B8B8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: const Text('J',
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by name, number...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Chats',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Call',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder<List<UserProfile>>(
                    stream: _databaseService.getUserProfiles(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Unable to load data'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Chats Available'));
                      }
                      final userProfiles = snapshot.data!;
                      return ListView.builder(
                        itemCount: userProfiles.length,
                        itemBuilder: (context, index) {
                          final profile = userProfiles[index];
                          print(profile.email);
                          return ListTile(
                            onTap: () => _handleChat(profile),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(profile.imageURL),
                            ),
                            title: Text(profile.name ?? 'No Name'),
                            subtitle: Text(profile.phone ?? 'No contact'),
                          );
                        },
                      );
                    },
                  ),
                  const Center(
                    child: Text(
                      'Call Logs will appear here.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff36B8B8),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactsPage()),
            );
          },
          child: const Icon(Icons.group),
        ),
      ),
    );
  }
}
