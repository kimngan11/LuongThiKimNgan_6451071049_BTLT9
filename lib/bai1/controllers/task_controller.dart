import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskController {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Lấy danh sách tasks realtime sắp xếp theo thời gian
  Stream<List<TaskModel>> getTasks() {
    return _tasksCollection.orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromDocument(doc)).toList();
    });
  }

  // Thêm task mới
  Future<void> addTask(String title) async {
    TaskModel newTask = TaskModel(title: title);
    await _tasksCollection.add(newTask.toJson());
  }

  // Cập nhật trạng thái công việc
  Future<void> updateTaskStatus(String id, bool isDone) async {
    await _tasksCollection.doc(id).update({'isDone': isDone});
  }

  // Xóa task
  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }
}
