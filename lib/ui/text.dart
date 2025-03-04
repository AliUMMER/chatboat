//     final chatId = _generateChatId(currentUser!.uid, widget.otherUser.uid);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff36B8B8),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: widget.otherUser.imageURL.isNotEmpty
//                   ? NetworkImage(widget.otherUser.imageURL)
//                   : AssetImage('assets/dp 2.png'),
//             ),
//             const SizedBox(width: 10),
//             Text(widget.otherUser.name),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .doc(chatId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final messages = snapshot.data!.docs;

//                 return ListView.builder(
//                   controller: _scrollController,
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     final senderId = message['senderId'];
//                     final isSent =
//                         senderId != null && senderId == currentUser!.uid;

//                     return Align(
//                       alignment:
//                           isSent ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 10),
//                         decoration: BoxDecoration(
//                           color:
//                               isSent ? const Color(0xffB5E2E2) : Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               message['text'],
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 _mediaMessageButton(),
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: const Color(0xff36B8B8),
//                   child: IconButton(
//                     icon: const Icon(Icons.send, color: Colors.white),
//                     onPressed: _sendMessage,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _mediaMessageButton() {
//     return IconButton(
//       icon: const Icon(Icons.image, color: Colors.white),
//       onPressed: () async {
//         File? file = await _mediaService.getImageFromGallery();
//         if (file != null) {
//           print("Image selected: ${file.path}");
//           // You can now upload and send the image as a message
//         }
//       },
//     );
//   }
// }
