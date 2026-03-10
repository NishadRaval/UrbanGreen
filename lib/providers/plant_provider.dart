import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant_model.dart';
import '../services/firebase_service.dart';
import '../services/auth_service.dart';

final userPlantsProvider = StreamProvider<List<PlantModel>>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final user = ref.watch(authStateProvider).value;

  if (user != null) {
    return firebaseService.getUserPlants(user.uid);
  }
  return const Stream.empty();
});
