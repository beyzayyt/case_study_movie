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
        title: Text(LocaleKeys.resetPassword.tr(), style: Theme.of(context).textTheme.subtitle1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              cursorColor: Colors.amber,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                hintText: 'Email',
                hintStyle: Theme.of(context).textTheme.subtitle1,
              ),
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
            context: context,
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
