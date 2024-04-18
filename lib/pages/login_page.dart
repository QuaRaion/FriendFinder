import 'package:flutter/material.dart';
import 'package:vers2/design/colors.dart';
import 'map_page.dart';
import 'signup.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                        const Padding(padding: EdgeInsets.only(top: 120),),
                        Image.asset(
                          'assets/img/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20),),
                        const Text("Вход",
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
                    buildTextField('Пароль'),
                    const Padding(padding: EdgeInsets.only(bottom: 30),),

                    MaterialButton(
                      minWidth: 200,
                      height: 70,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MapPage()));
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

                    const Padding(padding: EdgeInsets.only(bottom: 20),),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Нет аккаунта? ", style: TextStyle(
                          color: greyColor,
                          fontSize: 18,
                        ),),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text("Зарегистрироваться", style: TextStyle(

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

  Widget buildTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          obscureText: true, // Устанавливаем true, чтобы скрыть ввод
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }

}

