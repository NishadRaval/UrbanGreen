import 'package:cloud_firestore/cloud_firestore.dart';

class TradeItemModel {
  final String itemId;
  final String ownerId;
  final String itemName;
  final String description;
  final String? imageUrl;
  final String location;
  final int quantity;
  final DateTime createdAt;

  // Getters to bridge old UI usage
  String get id => itemId;
  String get userId => ownerId;
  String get authorName => 'Owner';
  int get availableQuantity => quantity;

  TradeItemModel({
    required this.itemId,
    required this.ownerId,
    required this.itemName,
    required this.description,
    this.imageUrl,
    required this.location,
    required this.quantity,
    required this.createdAt,
  });

  factory TradeItemModel.fromMap(Map<String, dynamic> map, String id) {
    return TradeItemModel(
      itemId: id,
      ownerId: map['ownerId'] ?? '',
      itemName: map['itemName'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      location: map['location'] ?? '',
      quantity: map['quantity'] ?? 1,
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'itemName': itemName,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'quantity': quantity,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
