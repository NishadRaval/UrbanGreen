import 'package:cloud_firestore/cloud_firestore.dart';

class TradeRequestModel {
  final String requestId;
  final String itemId;
  final String requesterId;
  final String status; // pending / accepted / rejected
  final DateTime createdAt;

  TradeRequestModel({
    required this.requestId,
    required this.itemId,
    required this.requesterId,
    required this.status,
    required this.createdAt,
  });

  factory TradeRequestModel.fromMap(Map<String, dynamic> map, String id) {
    return TradeRequestModel(
      requestId: id,
      itemId: map['itemId'] ?? '',
      requesterId: map['requesterId'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'requesterId': requesterId,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
