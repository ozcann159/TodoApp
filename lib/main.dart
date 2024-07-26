import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/pages/home_page.dart';
import 'package:todo_task_app/pages/login_page.dart';
import 'package:todo_task_app/pages/register_page.dart';
import 'package:todo_task_app/pages/todo_form_page.dart';
import 'package:todo_task_app/pages/todo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Kullanıcı oturum açmış mı kontrol et
  final user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isLoggedIn: user != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Uygulaması',
      initialRoute: isLoggedIn ? '/home' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/todo-list', page: () => TodoListPage()),
        GetPage(name: '/todo-form', page: () => TodoFormPage()),
      ],
    );
  }
}
