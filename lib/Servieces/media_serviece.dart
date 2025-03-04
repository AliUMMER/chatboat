import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  MediaService();

  // Pick an image from the gallery
  Future<File?> getImageFromGallery() async {
    final XFile? _file = await _picker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return File(_file.path);
    }
    return null;
  }

  // Upload image to Firebase Storage and return the download URL
  Future<String?> uploadImageToStorage(File file) async {
    try {
      String fileName =
          "chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference ref = _storage.ref().child(fileName);

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

      return await snapshot.ref.getDownloadURL(); // ✅ Return image URL
    } catch (e) {
      print("❌ Error uploading image: $e");
      return null;
    }
  }
}
