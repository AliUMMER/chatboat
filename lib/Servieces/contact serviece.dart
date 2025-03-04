import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Contact>> getPhoneContacts() async {
    if (await Permission.contacts.request().isGranted) {
      return await FlutterContacts.getContacts(withProperties: true);
    }
    return [];
  }

  Future<List<String>> getRegisteredUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();

    return snapshot.docs
        .where((doc) =>
            doc.data() != null &&
            (doc.data() as Map<String, dynamic>)
                .containsKey('phone')) // Check if 'phone' exists
        .map((doc) => _formatPhoneNumber(doc['phone'].toString()))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getMatchingContacts() async {
    List<String> registeredNumbers = await getRegisteredUsers();
    List<Contact> deviceContacts = await getPhoneContacts();

    List<Map<String, dynamic>> matchedContacts = [];
    for (var contact in deviceContacts) {
      if (contact.phones.isNotEmpty) {
        String phoneNumber = _formatPhoneNumber(contact.phones.first.number);
        if (registeredNumbers.contains(phoneNumber)) {
          matchedContacts.add({
            "name": contact.displayName,
            "phoneNumber": phoneNumber,
            "email": "",
            "imageURL": "",
          });
        }
      }
    }

    return matchedContacts;
  }

  String _formatPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }
}
