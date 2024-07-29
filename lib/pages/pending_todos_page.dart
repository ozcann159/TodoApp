import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';

import '../controllers/todo_controller.dart';

class PendingTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Obx(() {
      final todos = todoController.filteredPendingTodos;
      if (todos.isEmpty) {
        return Center(child: Text('No pending todos'));
      }
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];
          final createdAt =
              todo['createdAt']?.toDate(); // Timestamp'ı DateTime'a dönüştürün
          final formattedDate = createdAt != null
              ? DateFormat('dd MMM yyyy')
                  .format(createdAt) // Tarihi formatlayın
              : 'No Date';

          return Dismissible(
            key: Key(todo.id),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                todoController.deleteTodo(todo.id);
              }
            },
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    todoController.toggleTodoCompletion(todo.id, true);
                  },
                  child: todo['completed']
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.circle_outlined),
                ),
                title: Text(todo['title'] ?? 'Başlık Yok'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo['description'] ?? 'Açıklama Yok'),
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(() => TodoFormPage(todoId: todo.id, isUpdate: true));
                  },
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
