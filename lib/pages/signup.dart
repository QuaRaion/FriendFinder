import 'dart:convert';
import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:vers2/design/colors.dart';
import 'package:crypto/crypto.dart';
import 'map_page.dart';
import '../methods/registration_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  SignUpCubit() : super(SignUpInitial());

  void signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        print("User is successfully created");

        // Add user data to database
        await _addUserDataToDatabase(username, email, password);

        emit(SignUpSuccess());
      } else {
        print("Error");
        emit(SignUpFailure("Error during sign up"));
      }
    } catch (e) {
      print("Error: $e");
      emit(SignUpFailure(e.toString()));
    }
  }
  String hash_Password(String password) {
    var bytes = utf8.encode(password); // преобразование пароля в байтовый массив
    var digest = sha256.convert(bytes); // хеширование с использованием SHA-256

    return digest.toString(); // возвращаем хеш в виде строки
  }

  Future<void> _addUserDataToDatabase(String username, String email, String password) async {
    final firestore = FirebaseFirestore.instance.collection("users");
    String id = firestore.doc().id;

    await firestore.doc(id).set({
      "username": username,
      "email": email,
      "password": hash_Password(password),
    });
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String errorMessage;

  SignUpFailure(this.errorMessage);
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              } else if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
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
                _buildLoginTextField('Имя пользователя'),
                const SizedBox(height: 20),
                _buildEmailTextField('Почта'),
                const SizedBox(height: 20),
                _buildTextField('Пароль должен содержать не менее 6 символов', obscureText: true, controller: _passwordController),
                const SizedBox(height: 20),
                _buildTextField('Повторите пароль', obscureText: true, controller: _confirmPasswordController),
                const SizedBox(height: 30),
                MaterialButton(
                  minWidth: 350,
                  height: 80,
                  onPressed: () {
                    final username = _usernameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;

                    if (password == confirmPassword) {
                      BlocProvider.of<SignUpCubit>(context).signUp(
                        username: username,
                        email: email,
                        password: password,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пароли не совпадают'),
                        ),
                      );
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

  Widget _buildLoginTextField(String hintText) {
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

  Widget _buildEmailTextField(String hintText) {
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
          controller: _emailController,
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

  Widget _buildTextField(String hintText, {bool obscureText = false, required TextEditingController controller}) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: greyColor
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          onChanged: (value) {
            if (controller == _passwordController || controller == _confirmPasswordController) {
              BlocProvider.of<SignUpCubit>(context as BuildContext).emit(PasswordMatchChanged(
                isMatch: _passwordController.text == _confirmPasswordController.text,
              ));
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
}

class PasswordMatchChanged extends SignUpState {
  final bool isMatch;

  PasswordMatchChanged({required this.isMatch});
}

