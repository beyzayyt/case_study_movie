import 'package:case_study/main.dart';
import 'package:case_study/ui/search_movie_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/movie_button.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var incomingTitle = "";
  var incomingContent = "";

  Future<void> signUp() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("user_information")
          .doc(t1.text)
          .set({'key1': t1.text, 'key2': t2.text}).whenComplete(
              () => print("Kullanıcı firestore veritabanına eklendi"));
    }).whenComplete(() => print("Kullanıcı firebase e kaydedildi"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: MediaQuery.of(context).size.height / 2,
          margin: const EdgeInsets.fromLTRB(0, 90, 0, 0),
          child: Center(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: t1,
                    decoration: const InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: t2,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MovieButton(
                        buttonDescription:'Kaydol',
                        onPressed: () {
                          signUp();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (BuildContext context) =>
                              MovieRecomenderHome()));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(incomingTitle),
                    subtitle: Text(incomingContent),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}