import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreMapExtension on Map<String, dynamic> {
  // 1. Convert Timestamp to DateTime 
  DateTime toDateTime(String key) {
    final value = this[key];
    if (value is Timestamp) {
      return value.toDate();
    }
    return DateTime.now(); 
  }

  // 2. Safely convert num to int
  int toIntSafe(String key) {
    final value = this[key];
    if (value is num) {
      return value.toInt();
    }
    return 0;
  }
}