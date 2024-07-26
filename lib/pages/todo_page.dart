import 'package:flutter/material.dart';
import 'completed_todos_page.dart';
import 'pending_todos_page.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // İki tab
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tamamlanmış'),
              Tab(text: 'Tamamlanmamış'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CompletedTodosPage(),
            PendingTodosPage(),
          ],
        ),
      ),
    );
  }
}
