import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('todos')
          .where('isCompleted', isEqualTo: false)
          .orderBy('createdAt', descending: true) // Sıralama
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final todos = snapshot.data!.docs;

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(todo['title']),
            );
          },
        );
      },
    );
  }
}
