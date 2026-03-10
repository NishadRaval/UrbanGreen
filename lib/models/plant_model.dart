import 'package:cloud_firestore/cloud_firestore.dart';

class PlantModel {
  final String plantId;
  final String userId;
  final String plantName;
  final DateTime datePlanted;
  final String growthStage;
  final String wateringSchedule;
  final String? notes;
  final String? imageUrl;
  final DateTime createdAt;

  // Added getters to keep existing UI from breaking heavily
  String get id => plantId;
  String get name => plantName;
  String? get photoUrl => imageUrl; 

  PlantModel({
    required this.plantId,
    required this.userId,
    required this.plantName,
    required this.datePlanted,
    required this.growthStage,
    required this.wateringSchedule,
    this.notes,
    this.imageUrl,
    required this.createdAt,
  });

  factory PlantModel.fromMap(Map<String, dynamic> map, String id) {
    return PlantModel(
      plantId: id,
      userId: map['userId'] ?? '',
      plantName: map['plantName'] ?? '',
      datePlanted: map['datePlanted'] != null 
          ? (map['datePlanted'] as Timestamp).toDate() 
          : DateTime.now(),
      growthStage: map['growthStage'] ?? 'Seedling',
      wateringSchedule: map['wateringSchedule'] ?? 'Daily',
      notes: map['notes'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'plantName': plantName,
      'datePlanted': Timestamp.fromDate(datePlanted),
      'growthStage': growthStage,
      'wateringSchedule': wateringSchedule,
      'notes': notes,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
