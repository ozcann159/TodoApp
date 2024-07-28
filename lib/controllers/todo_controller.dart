import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var todos = <DocumentSnapshot>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('todos')
          .doc(userId)
          .collection('userTodos')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        todos.value = snapshot.docs;
      });
    }
  }

  List<DocumentSnapshot> get filteredPendingTodos {
    if (searchQuery.isEmpty) {
      return todos.where((todo) => !(todo['completed'] ?? false)).toList();
    } else {
      return todos.where((todo) =>
          !(todo['completed'] ?? false) &&
          (todo['description']?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
      ).toList();
    }
  }

  List<DocumentSnapshot> get filteredCompletedTodos {
    if (searchQuery.isEmpty) {
      return todos.where((todo) => todo['completed'] ?? false).toList();
    } else {
      return todos.where((todo) =>
          (todo['completed'] ?? false) &&
          (todo['description']?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
      ).toList();
    }
  }

  Future<void> deleteTodo(String todoId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(userId)
          .collection('userTodos')
          .doc(todoId)
          .delete();
      // fetchTodos(); // snapshots methoduyla gerek kalmıyor
    }
  }

  Future<void> toggleTodoCompletion(String todoId, bool completed) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(userId)
          .collection('userTodos')
          .doc(todoId)
          .update({'completed': completed});
      // fetchTodos(); // snapshots methoduyla gerek kalmıyor
    }
  }
}
