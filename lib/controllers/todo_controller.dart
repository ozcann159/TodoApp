import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var searchQuery = ''.obs; // Arama sorgusunu tutacak reaktif değişken

  RxList<DocumentSnapshot> todos = <DocumentSnapshot>[].obs; // Tüm todo'ları tutacak liste

  
  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    // Todo'ları Firestore'dan çek
    final todoCollection = _firestore.collection('todos');
    todoCollection.snapshots().listen((snapshot) {
      todos.value = snapshot.docs;
    });
  }

   List<DocumentSnapshot> get filteredPendingTodos {
    // Arama sorgusuna göre filtrelenmiş tamamlanmamış todo'lar
    return todos.where((todo) {
      final title = todo['title']?.toString() ?? '';
      final isCompleted = todo['completed'] ?? false;
      return !isCompleted && title.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  List<DocumentSnapshot> get filteredCompletedTodos {
    // Arama sorgusuna göre filtrelenmiş tamamlanmış todo'lar
    return todos.where((todo) {
      final title = todo['title']?.toString() ?? '';
      final isCompleted = todo['completed'] ?? false;
      return isCompleted && title.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  // Arama fonksiyonu
  List<DocumentSnapshot> get filteredTodos {
    if (searchQuery.value.isEmpty) {
      return todos;
    } else {
      return todos.where((todo) {
        final title = todo['title']?.toString() ?? '';
        return title.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  // Todo'nun tamamlanmasını değiştiren metot
  void toggleTodoCompletion(String id, bool isCompleted) async {
    await _firestore.collection('todos').doc(id).update({'completed': isCompleted});
  }

  // Todo ekleme
  Future<void> addTodo(Map<String, dynamic> todoData) async {
    await _firestore.collection('todos').add(todoData);
  }

  // Todo güncelleme
  Future<void> updateTodo(String todoId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('todos').doc(todoId).update(updatedData);
  }

  // Todo silme
  Future<void> deleteTodo(String todoId) async {
    await _firestore.collection('todos').doc(todoId).delete();
  }

  // Todo'ları alma
  Future<DocumentSnapshot> getTodoById(String todoId) async {
    return await _firestore.collection('todos').doc(todoId).get();
  }
}
