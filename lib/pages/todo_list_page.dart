import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';
import '../controllers/todo_controller.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(() => TodoFormPage()),
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.filteredPendingTodos.isEmpty) {
          return Center(child: Text('No pending todos'));
        }
        return ListView.builder(
          itemCount: todoController.filteredPendingTodos.length,
          itemBuilder: (context, index) {
            var todo = todoController.filteredPendingTodos[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(todo['title'] ?? 'No Title'),
                trailing: IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    todoController.toggleTodoCompletion(todo.id, true);
                  },
                ),
                onLongPress: () {
                  Get.to(() => TodoFormPage(todoId: todo.id, isUpdate: true));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
