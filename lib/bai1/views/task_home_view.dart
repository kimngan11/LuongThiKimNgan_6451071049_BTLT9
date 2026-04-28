import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TaskHomeView extends StatefulWidget {
  @override
  _TaskHomeViewState createState() => _TaskHomeViewState();
}

class _TaskHomeViewState extends State<TaskHomeView> {
  final TaskController _controller = TaskController();
  final TextEditingController _textController = TextEditingController();

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thêm công việc mới"),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: "Nhập tiêu đề công việc"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textController.clear();
                Navigator.pop(context);
              },
              child: Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _controller.addTask(_textController.text);
                  _textController.clear();
                  Navigator.pop(context);
                }
              },
              child: Text("Lưu"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 1: To-do List"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            color: Colors.blue[100],
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Sinh viên: Lương Thị Kim Ngân - MSSV: 6451071049",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: _controller.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Đã xảy ra lỗi. Vui lòng kiểm tra Firebase Rules."));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Chưa có công việc nào. Hãy thêm mới!"));
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id!),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _controller.deleteTask(task.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("\${task.title} đã bị xóa")),
                  );
                },
                child: CheckboxListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: task.isDone,
                  onChanged: (bool? value) {
                    _controller.updateTaskStatus(task.id!, value ?? false);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
