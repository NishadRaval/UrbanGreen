import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant_model.dart';
import '../models/post_model.dart';
import '../models/trade_item_model.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) => FirebaseService());

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- PLANTS ---
  Stream<List<PlantModel>> getUserPlants(String userId) {
    return _firestore
        .collection('plants')
        .where('userId', isEqualTo: userId)
        .orderBy('datePlanted', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlantModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addPlant(PlantModel plant) async {
    await _firestore.collection('plants').doc().set(plant.toMap());
  }

  Future<void> deletePlant(String plantId) async {
    await _firestore.collection('plants').doc(plantId).delete();
  }

  // --- POSTS ---
  Stream<List<PostModel>> getCommunityPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> createPost(PostModel post) async {
    await _firestore.collection('posts').doc().set(post.toMap());
  }

  Future<void> likePost(String postId, String userId, bool isLiked) async {
    if (isLiked) {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }

  // --- MARKETPLACE ---
  Stream<List<TradeItemModel>> getTradeItems() {
    return _firestore
        .collection('trade_items')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TradeItemModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addTradeItem(TradeItemModel item) async {
    await _firestore.collection('trade_items').doc().set(item.toMap());
  }
}
