import 'package:flutter/material.dart';
import 'dart:core';
import 'package:vers2/design/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

        body: Container(
          alignment: Alignment. center,
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 60),),
                        Image.asset(
                          'assets/img/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20),),
                        const Text("Регистрация",
                            style: TextStyle(
                                fontSize: 35,
                                color: blackColor,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 30),)
                      ],
                    ),

                    buildLoginTextField('Логин'),
                    const Padding(padding: EdgeInsets.only(bottom: 20),),
                    buildEmailTextField('Почта'),
                    const Padding(padding: EdgeInsets.only(bottom: 20),),
                    buildTextField('Пароль', obscureText: true, controller: _passwordController),
                    const Padding(padding: EdgeInsets.only(bottom: 20),),
                    buildTextField('Повторный пароль', obscureText: true, controller: _confirmPasswordController),
                    const Padding(padding: EdgeInsets.only(bottom: 30),),

                    MaterialButton(
                      minWidth: 350,
                      height: 80,


                      onPressed: () {
                        // Проверка введенной почты перед переходом на другой экран
                        if (_isEmailValid) {
                          Navigator.pop(context);
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

                    const Padding(padding: EdgeInsets.only(bottom: 20),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Уже есть аккаунт? ", style: TextStyle(
                          color: greyColor,
                          fontSize: 18,
                        ),),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Войти", style: TextStyle(

                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),)
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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,

            ),
            // errorText: _isEmailValid ? null : 'Введите корректный адрес электронной почты',
            // errorStyle: TextStyle(
            //   fontSize: 14.0,
            //   color: Colors.red,
            // ),
          ),

          onChanged: (value) {
            setState(() {
              _isEmailValid = RegExp(
                r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          obscureText: obscureText, //скрытие пароля
          // obscureText: hintText.toLowerCase().contains('password'),
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
              fontSize: 18,
            ),

          ),
        ),
      ),
    );
  }
}
