import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'component/movie_button.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  late String _email;
  final auth = FirebaseAuth.instance;
  String description = "Kayıt olduğunuz e-mail hesabınız ile istek yollarayak mail adresinize gelen bağlantıdan gerekli şifre değişimini yapabilirsiniz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        elevation: 0,
        title: const Text("Şifre Sıfırlama",style: TextStyle(color: Colors.amber)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(description, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MovieButton(
            buttonDescription: 'İstek yolla',
            onPressed: () {
              auth.sendPasswordResetEmail(email: _email);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
