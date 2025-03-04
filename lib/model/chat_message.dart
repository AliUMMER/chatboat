import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { Text, Image }

class Message {
  String senderID;
  String content;
  MessageType messageType;
  Timestamp sentAt;

  Message({
    required this.senderID,
    required this.content,
    required this.messageType,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'] ?? '',
      content: json['content'] ?? '',
      messageType: _parseMessageType(json['messageType']),
      sentAt: (json['sentAt'] is Timestamp)
          ? json['sentAt'] as Timestamp
          : Timestamp.fromDate(DateTime.now()), // Fallback to current time
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'content': content,
      'messageType': messageType.name,
      'sentAt': sentAt,
    };
  }

  /// Safely parses the message type
  static MessageType _parseMessageType(dynamic value) {
    if (value is String) {
      return MessageType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => MessageType.Text,
      );
    }
    return MessageType.Text; // Default fallback
  }
}
