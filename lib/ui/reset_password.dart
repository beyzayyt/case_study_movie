import 'package:case_study/localization/local_keys.dart';
import 'package:easy_localization/src/public_ext.dart';
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
  String description = LocaleKeys.resetPasswordDescription.tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        elevation: 0,
        title:  Text(LocaleKeys.resetPassword.tr(),style: TextStyle(color: Colors.amber)),
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
            buttonDescription: LocaleKeys.resetSendRequest.tr(),
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
