import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../services/firebase_service.dart';

final communityPostsProvider = StreamProvider<List<PostModel>>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return firebaseService.getCommunityPosts();
});
