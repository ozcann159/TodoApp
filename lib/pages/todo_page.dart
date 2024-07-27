import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';
import 'completed_todos_page.dart';
import 'pending_todos_page.dart';
import 'todo_form_page.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Ara',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      todoController.searchQuery.value = value;
                    },
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(text: 'Tamamlanmış'),
                    Tab(text: 'Tamamlanmamış'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            CompletedTodosPage(),
            PendingTodosPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => TodoFormPage());
          },
          child: Icon(Icons.add),
          tooltip: 'Todo Ekle',
        ),
      ),
    );
  }
}
