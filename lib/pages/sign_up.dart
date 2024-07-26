import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  // GlobalKey<FormState> ekleyin
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Image.asset('assets/images/sign.jpg',
                    height: 300, width: double.infinity, fit: BoxFit.cover),
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Obx(() => TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onChanged: (value) =>
                                authController.email.value = value,
                            validator: (value) {
                              if (!authController.validateEmail(value ?? '')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: 10),
                      Obx(() => TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.password)),
                            onChanged: (value) =>
                                authController.password.value = value,
                            validator: (value) {
                              if (!authController
                                  .validatePassword(value ?? '')) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: 10),
                      Obx(() => TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.password)),
                            onChanged: (value) =>
                                authController.passwordConfirm.value = value,
                            validator: (value) {
                              if (authController.password.value != value) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            authController.signUp();
                          } else {
                            // Hata mesajlarını göster
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
