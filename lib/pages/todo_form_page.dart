import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoFormPage extends StatefulWidget {
  @override
  _TodoFormPageState createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final _titleController = TextEditingController();
  bool _isCompleted = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final todoId = Get.arguments;
    if (todoId != null) {
      _loadTodoData(todoId);
    }
  }

  Future<void> _loadTodoData(String todoId) async {
    final doc = await FirebaseFirestore.instance.collection('todos').doc(todoId).get();
    final data = doc.data();
    setState(() {
      _titleController.text = data?['title'] ?? '';
      _isCompleted = data?['completed'] ?? false;
    });
  }

  void _saveTodo() async {
    if (_formKey.currentState?.validate() ?? false) {
      final todoData = {
        'title': _titleController.text,
        'completed': _isCompleted,
        'createdAt': Timestamp.now(),
      };

      final todoId = Get.arguments;
      if (todoId != null) {
        // Güncelle
        await FirebaseFirestore.instance.collection('todos').doc(todoId).update(todoData);
      } else {
        // Ekle
        await FirebaseFirestore.instance.collection('todos').add(todoData);
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Formu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlık girin';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Tamamlandı'),
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTodo,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
