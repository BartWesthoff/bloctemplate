import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  /// Get singleton instance of [StorageService]
  static final instance = StorageService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload given [file] to the provided [path]
  /// returns the downloadUrl for the uploaded file.
  Future<dynamic> uploadFile(String path, File file) async {
    final Reference ref = _storage.ref().child(path);
    final UploadTask uploadTask = ref.putFile(file);
    await uploadTask;
    return ref.getDownloadURL();
  }
}
