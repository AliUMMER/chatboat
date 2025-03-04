String generateChatId({required String uid1, required String uid2}) {
  List<String> uids = [uid1, uid2]..sort();
  String chatId = uids.fold("", (id, uid) => "$id$uid");
  return chatId;
}
