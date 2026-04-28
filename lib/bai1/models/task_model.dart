import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String title;
  bool isDone;
  Timestamp? createdAt;

  TaskModel({this.id, required this.title, this.isDone = false, this.createdAt});

  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    return TaskModel(
      id: doc.id,
      title: doc['title'],
      isDone: doc['isDone'] ?? false,
      createdAt: doc['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
