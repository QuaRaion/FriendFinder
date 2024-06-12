import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vers2/design/colors.dart';
import '../methods/registration_methods.dart';
import 'map_page.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: accentColor),
      home: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit, User?>(
        listener: (context, user) {
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MapPage()),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 120)),
                        Image.asset(
                          'assets/img/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        const Text(
                          "Вход",
                          style: TextStyle(
                            fontSize: 35,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 30)),
                      ],
                    ),
                    _buildLoginTextField('Адрес электронной почты', _emailController),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    _buildTextField('Пароль', _passwordController),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),

                    MaterialButton(
                      minWidth: 200,
                      height: 70,
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context).signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      color: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Войти",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(bottom: 20)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Нет аккаунта? ",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Зарегистрироваться",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTextField(String hintText, TextEditingController controller) {
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
          controller: controller,
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

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        child: TextField(
          controller: controller,
          obscureText: true,
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

class LoginCubit extends Cubit<User?> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  LoginCubit() : super(null);

  Future<void> signIn(String email, String password) async {
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("Пользователь зарегистрирован");
      emit(user);
    } else {
      print("Ошибка регистрации");
      emit(null);
    }
  }
}
