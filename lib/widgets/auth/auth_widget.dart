

import "package:flutter/material.dart";
import 'package:themoviedb/Theme/app_button_style.dart';


class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login your account'),
        centerTitle: true,
      ),
      body: const _HeaderWidget()
    );
  }
}


class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 15,
      color: Colors.black,
    );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const _FormWidget(),
            const SizedBox(height: 20,),
            const Text(
            'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.',
            style: textStyle,
            ),
            const SizedBox(height: 4,),
            TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {}, 
              child: const Text('Регистрация')),
            const SizedBox(height: 15,),
            const Text(
              'Если Вы зарегистрировались, но не получили письмо для подтверждения,',
              style: textStyle,
              ),
            const SizedBox(height: 4,),
            TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {}, 
              child: const Text('Верификация email')),

          ],
        ),
      );
  }
}


class _FormWidget extends StatefulWidget {
  const _FormWidget();

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {

  final _loginTextController = TextEditingController(text: 'admin');
  final _passwordTextController = TextEditingController(text: 'admin');

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if(login == 'admin' && password == 'admin') {
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.pink.withOpacity(0.7),
          content: const Text('Не верный логин ил пароль') )
      );
    }
  }
  
  void _resetPassword() {
    _passwordTextController.clear();
  }
  @override
  
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 15,
        color: Color(0xFF212529),
      );
    const color = Color(0xFF01B4E4);
    const textFieldDecoration = InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        isCollapsed: true
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: textStyle,
          ),
        const SizedBox(height: 5,),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecoration
        ),
        const Text(
          'Password',
          style: textStyle,
          ),
        const SizedBox(height: 5,),
        TextField(
          controller: _passwordTextController,
          decoration: textFieldDecoration,
          obscureText: true,
        ),
        const SizedBox(height: 24,),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle:  MaterialStateProperty.all(
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8
                  )
                )
              ),
              child: const Text('Войти')
              ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text('Сбросить пароль')
              ),
          ],
        )
      ],
    );
  }
}

