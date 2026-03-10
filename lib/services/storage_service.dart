import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile, String path) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = _storage.ref().child('$path/$fileName.jpg');
      
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> uploadPlantImage(File imageFile, String userId) async {
    return uploadImage(imageFile, 'users/$userId/plants');
  }

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    return uploadImage(imageFile, 'users/$userId/profile');
  }

  Future<String?> uploadPostImage(File imageFile, String userId) async {
    return uploadImage(imageFile, 'users/$userId/posts');
  }
}
