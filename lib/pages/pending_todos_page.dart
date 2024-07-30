import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';

import '../controllers/todo_controller.dart';

class PendingTodosPage extends StatelessWidget {
  const PendingTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Obx(() {
      final todos = todoController.filteredPendingTodos;
      if (todos.isEmpty) {
        return const Center(
            child: Text(
          'No pending todos',
          style: TextStyle(color: Colors.white),
        ));
      }
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];
          final createdAt =
              todo['createdAt']?.toDate(); // Timestamp'ı DateTime'a dönüştür
          final formattedDate = createdAt != null
              ? DateFormat('dd MMM yyyy').format(createdAt) // Tarihi formatla
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
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      todoController.toggleTodoCompletion(todo.id, true);
                    },
                    child: todo['completed']
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.circle_outlined),
                  ),
                  title: Text(
                    todo['title'] ?? 'Başlık Yok',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo['description'] ?? 'Açıklama Yok'),
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 300, // Genişlik
                              height: 400, // Yükseklik
                              child: TodoFormPage(
                                todoId: todo.id,
                                isUpdate: true,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ));
        },
      );
    });
  }
}
