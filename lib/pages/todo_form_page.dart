import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/todo_controller.dart';

class TodoFormPage extends StatelessWidget {
  final String? todoId;
  final bool isUpdate;

  TodoFormPage({this.todoId, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();
    final TextEditingController titleController = TextEditingController();

    if (isUpdate && todoId != null) {
      // Todo'yu güncelleme durumunda, ID'ye göre verileri yükleyin
      todoController.getTodoById(todoId!).then((todo) {
        titleController.text = todo['title'] ?? '';
      }).catchError((error) {
        // Hata işleme
        print("Error fetching todo: $error");
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  if (isUpdate && todoId != null) {
                    await todoController.updateTodo(todoId!, {'title': title});
                  } else {
                    await todoController.addTodo({
                      'title': title,
                      'completed': false,
                      'createdAt': Timestamp.now(),
                    });
                  }
                  Get.back(); // Geri dön
                }
              },
              child: Text(isUpdate ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
