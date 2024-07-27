import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Tüm todo'ları getirir
  Stream<List<DocumentSnapshot>> getTodos({required bool completed}) {
    return _db
        .collection('todos')
        .where('completed', isEqualTo: completed)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Belirli bir todo'yu ID ile getirir
  Future<DocumentSnapshot> getTodoById(String id) async {
    return await _db.collection('todos').doc(id).get();
  }

  // Yeni bir todo ekler
  Future<void> addTodo(Map<String, dynamic> todo) async {
    await _db.collection('todos').add(todo);
  }

  // Var olan bir todo'yu günceller
  Future<void> updateTodo(String id, Map<String, dynamic> data) async {
    await _db.collection('todos').doc(id).update(data);
  }

  // Var olan bir todo'yu siler
  Future<void> deleteTodo(String id) async {
    await _db.collection('todos').doc(id).delete();
  }
}
