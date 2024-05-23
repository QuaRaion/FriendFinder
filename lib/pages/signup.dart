import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:vers2/design/colors.dart';
import '../methods/registration_methods.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'map_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordMatch = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: accentColor),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 60)),
                Image.asset(
                  'assets/img/logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Регистрация",
                  style: TextStyle(
                    fontSize: 35,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                buildLoginTextField('Имя пользователя'),
                const SizedBox(height: 20),
                buildEmailTextField('Почта'),
                const SizedBox(height: 20),
                buildTextField('Пароль должен содержать не менее 6 символов', obscureText: true, controller: _passwordController),
                const SizedBox(height: 20),
                buildTextField('Повторите пароль', obscureText: true, controller: _confirmPasswordController),
                const SizedBox(height: 30),
                // MaterialButton(
                //   minWidth: double.infinity,
                //   height: 60,
                //   onPressed: () {
                //     if (_isEmailValid) {
                //       _signUp();
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('Введите корректный адрес электронной почты'),
                //         ),
                //       );
                //     }
                //   },
                //   color: accentColor,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50),
                //   ),
                //   child: const Text(
                //     "Зарегистрироваться",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                MaterialButton(
                  minWidth: 350,
                  height: 80,


                  onPressed: () {
                    // Проверка введенной почты перед переходом на другой экран
                    if (_isEmailValid) {
                      _signUp();
                      //реализия сохранения ин-фы о пользователе в БД
                    } else {
                      // // Вывод сообщения об ошибке
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Введите корректный адрес электронной почты'),
                      //   ),
                      // );
                    }
                  },
                  color: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Уже есть аккаунт? ",
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Войти",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: greyColor,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _isEmailValid ? greyColor : Colors.red,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _isEmailValid = RegExp(
                // r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
                r"^[a-zA-Z0-9+_.]+@[a-zA-Z0-9.]+\.[a-zA-Z]{2,}$",

              ).hasMatch(value);
            });
          },
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, {bool obscureText = false, required TextEditingController controller}) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isPasswordMatch ? greyColor : Colors.red,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          onChanged: (value) {
            if (controller == _passwordController || controller == _confirmPasswordController) {
              setState(() {
                _isPasswordMatch = _passwordController.text == _confirmPasswordController.text;
              });
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
            ),
          ),
        ),
      ),
    );
  }

  String hash_Password(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String hashPassword = hash_Password(password);

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MapPage()));
    } else {
      print("Error");
    }

    final firestore = FirebaseFirestore.instance.collection("users");
    String id = firestore.doc().id;

    await firestore.doc(id).set({
      "username": username,
      "email": email,
      "password": hashPassword,
    });
  }
}
