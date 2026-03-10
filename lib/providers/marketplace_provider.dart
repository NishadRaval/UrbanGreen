import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trade_item_model.dart';
import '../services/firebase_service.dart';

final tradeItemsProvider = StreamProvider<List<TradeItemModel>>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return firebaseService.getTradeItems();
});
