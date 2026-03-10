import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  final user = authService.currentUser;
  
  if (user != null) {
    return await authService.getUserData(user.uid);
  }
  return null;
});

// A simple notifier to handle Loading states during Auth
class AuthStateNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  
  void setLoading(bool val) => state = val;
}

final authLoadingProvider = NotifierProvider<AuthStateNotifier, bool>(() {
  return AuthStateNotifier();
});
