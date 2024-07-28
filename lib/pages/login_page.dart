import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Get.offNamed('/todo-page');  // Başarılı girişten sonra yönlendirme
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'Bir hata oluştu');
      } catch (e) {
        Get.snackbar('Error', 'Bir hata oluştu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-posta'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Geçerli bir e-posta girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Şifre en az 8 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: Text('Giriş Yap'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
