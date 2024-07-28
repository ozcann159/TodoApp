import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoFormPage extends StatefulWidget {
  final String? todoId;
  final bool isUpdate;

  TodoFormPage({this.todoId, required this.isUpdate});

  @override
  _TodoFormPageState createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.todoId != null) {
      _loadTodoData();
    }
  }

  Future<void> _loadTodoData() async {
    DocumentSnapshot todo = await FirebaseFirestore.instance
        .collection('todos')
        .doc(user!.uid)
        .collection('userTodos')
        .doc(widget.todoId)
        .get();

    Map<String, dynamic>? data = todo.data() as Map<String, dynamic>?;
    if (data != null) {
      titleController.text = data['title'] ?? '';
      descriptionController.text = data['description'] ?? '';
    }
  }

  Future<void> _saveTodo() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.isUpdate && widget.todoId != null) {
          // Todo güncelle
          await FirebaseFirestore.instance
              .collection('todos')
              .doc(user!.uid)
              .collection('userTodos')
              .doc(widget.todoId)
              .update({
            'title': titleController.text,
            'description': descriptionController.text,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Yeni todo ekle
          await FirebaseFirestore.instance
              .collection('todos')
              .doc(user!.uid)
              .collection('userTodos')
              .add({
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        Get.back();
      } catch (e) {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Todo Güncelle' : 'Yeni Todo Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlık gerekli';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama gerekli';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTodo,
                child: Text(widget.isUpdate ? 'Güncelle' : 'Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
