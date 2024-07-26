// completed_todos_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompletedTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('todos')
          .where('isCompleted', isEqualTo: true)
          .orderBy('cretedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
          final todos = snapshot.data!.docs;

          return ListView.builder(itemBuilder: (context, index) {
            final todo = todos[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(todo['title']),
            );
          },);
      },
    );
  }
}
