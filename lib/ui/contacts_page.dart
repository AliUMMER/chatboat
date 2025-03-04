import 'package:chatboat/Servieces/auth_serviece.dart';
import 'package:chatboat/Servieces/contact%20serviece.dart';
import 'package:chatboat/Servieces/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatboat/ui/chat_page.dart';
import 'package:chatboat/model/chat_user.dart';
import 'package:get_it/get_it.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final ContactService _contactService = ContactService();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ChatUser> contacts = [];
  bool isLoading = true;
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    fetchRegisteredContacts();
    printAllFirestoreUsers(); // ✅ Debug Firestore users
  }

  Future<void> printAllFirestoreUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();

      if (snapshot.docs.isEmpty) {
        print("No users found in Firestore.");
        return;
      }

      print("🔥 Firestore Users:");
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(
            "🆔 ID: ${doc.id}, 📞 Phone: ${data['phone']}, 🏷️ Name: ${data['name'] ?? 'Unknown'}");
      }
    } catch (e) {
      print("❌ Error fetching users from Firestore: $e");
    }
  }

  Future<List<String>> getRegisteredUsers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs
        .map((doc) => _normalizePhoneNumber(doc['phone'].toString()))
        .toList();
  }

  String _normalizePhoneNumber(String phone) {
    phone =
        phone.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters

    if (phone.length > 10 && phone.startsWith('+91')) {
      phone = phone.substring(phone.length - 10);
    }

    return phone;
  }

  Future<void> fetchRegisteredContacts() async {
    try {
      // Fetch registered users from Firestore (including UID)
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Store phone-to-user mapping (to get UID later)
      Map<String, Map<String, dynamic>> registeredUsers = {};

      for (var doc in snapshot.docs) {
        String normalizedPhone = _normalizePhoneNumber(doc['phone'].toString());
        registeredUsers[normalizedPhone] = {
          'uid': doc.id, // Firestore document ID (User UID)
          'name': doc['name'] ?? 'Unknown',
          'email': doc['email'] ?? '',
          'phone': doc['phone'] ?? '',
          'imageURL': doc['imageURL'] ?? '',
        };
      }

      print("🔥 Firestore Users: $registeredUsers");

      // Fetch local contacts
      List<Map<String, dynamic>> localContacts =
          await _contactService.getMatchingContacts();

      print("📱 Local Contacts: $localContacts");

      // Match local contacts with registered users
      List<ChatUser> matchedContacts = [];

      for (var contact in localContacts) {
        if (!contact.containsKey('phoneNumber') ||
            contact['phoneNumber'] == null) {
          continue;
        }

        String normalizedLocalPhone =
            _normalizePhoneNumber(contact['phoneNumber'].toString());

        // Check if the contact is registered
        if (registeredUsers.containsKey(normalizedLocalPhone)) {
          var firestoreUser = registeredUsers[normalizedLocalPhone];

          matchedContacts.add(ChatUser.fromMap({
            'uid': firestoreUser!['uid'], // ✅ Get UID from Firestore
            'name': firestoreUser['name'],
            'phone': firestoreUser['phone'],
            'email': firestoreUser['email'],
            'imageURL': firestoreUser['imageURL'],
          }));
        }
      }

      print("✅ Matched Contacts: $matchedContacts");

      // Update state
      setState(() {
        contacts = matchedContacts;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error fetching contacts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : contacts.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final user = contacts[index];
                            return _buildContactTile(user);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xff36B8B8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text("No registered contacts found",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildContactTile(ChatUser user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              otherUser: ChatUser(
                uid: user.uid, // Ensure this exists
                name: user.name,
                email: user.email,
                imageURL: user.imageURL,
                lastActive: DateTime.now(),
              ),
            ),
          ),
        );
      },
      child: ListTile(
        leading: user.imageURL.isNotEmpty && user.imageURL.startsWith('http')
            ? CircleAvatar(backgroundImage: NetworkImage(user.imageURL))
            : const CircleAvatar(
                backgroundImage: AssetImage('assets/default_user.png')),
        title: Text(user.name),
        subtitle: Text(user.lastActive
            .toString()), // Fixed subtitle (used phone instead of lastActive)
      ),
    );
  }
}
