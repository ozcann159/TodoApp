import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';

import '../controllers/todo_controller.dart';

class CompletedTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Obx(() {
      final todos = todoController.filteredCompletedTodos;
      if (todos.isEmpty) {
        return Center(child: Text('No completed todos'));
      }
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                todo['title'] ?? 'No Title',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo['description'] ?? 'No Description'),
                  Text(
                    todo['createdAt']?.toDate().toString() ?? 'No Date',
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
          );
        },
      );
    });
  }
}
