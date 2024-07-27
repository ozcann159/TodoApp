import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';
import '../controllers/todo_controller.dart';

class PendingTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Obx(() {
      return ListView.builder(
        itemCount: todoController.filteredPendingTodos.length,
        itemBuilder: (context, index) {
          var todo = todoController.filteredPendingTodos[index];

          return Dismissible(
            key: Key(todo.id), // Her item için unique bir key kullanmalısınız
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // Silme işlemi
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
                leading: todo['completed']
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.circle_outlined),
                title: Text(todo['title'] ?? 'Başlık Yok'),
                subtitle: Text(todo['createdAt']?.toDate().toString() ?? 'Tarih Yok'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Güncelleme sayfasına geçiş
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
