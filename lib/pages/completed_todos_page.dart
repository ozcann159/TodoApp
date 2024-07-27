import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class CompletedTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Obx(() {
      return ListView.builder(
        itemCount: todoController.filteredCompletedTodos.length,
        itemBuilder: (context, index) {
          var todo = todoController.filteredCompletedTodos[index];
          return ListTile(
            title: Text(todo['content']),
            subtitle: Text(todo['createdAt'].toDate().toString()),
          );
        },
      );
    });
  }
}

