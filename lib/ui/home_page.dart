import 'package:case_study/localization/local_keys.dart';
import 'package:case_study/logic/cubit/switch_cubit.dart';
import 'package:case_study/ui/reset_password.dart';
import 'package:case_study/ui/search_movie_page.dart';
import 'package:case_study/ui/sign_up_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'component/lottie_animation.dart';
import 'component/movie_button.dart';
import 'dialog_lang.dart';

class MovieRecommenderHome extends StatefulWidget {
  const MovieRecommenderHome({Key? key}) : super(key: key);

  @override
  State<MovieRecommenderHome> createState() => _MovieRecommenderHomeState();
}

class _MovieRecommenderHomeState extends State<MovieRecommenderHome> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var incomingTitleUsername = "";
  var incomingContentUsername = "";
  var incomingTitlePassword = "";
  var incomingContentPassword = "";

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: t1.text,
          password: t2.text
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SearchMovie()));
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("${e.message}"),
            );
          });
    }
    t1.clear();
    t2.clear();
  }

  void deletingText() {
    // Delete data
    FirebaseFirestore.instance.collection("user_information").doc(t1.text).delete();
  }

  void updatingText() {
    // Update data
    FirebaseFirestore.instance
        .collection("user_information")
        .doc(t1.text)
        .update({'title': t1.text, 'content': t2.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Theme.of(context).brightness),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<SwitchCubit, SwitchState>(
            builder: (context, state) {
              return Switch(
                activeColor: Colors.grey[600],
                value: state.isDarkThemeOn,
                onChanged: (newValue) {
                  context.read<SwitchCubit>().toggleSwitch(newValue);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LottieAnimation(
              context: context,
              path: 'assets/lottie/movie.json',
              descriptionTitle: LocaleKeys.homeLottieDescriptionTitle.tr(),
              description: LocaleKeys.homeLottieDescription.tr(),
            ),
            MovieButton(
              context: context,
              onPressed: () {
                showModalBottomSheet<dynamic>(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                  cursorColor: Colors.amber,
                                  keyboardType: TextInputType.text,
                                  controller: t1,
                                  decoration: InputDecoration(
                                    hintText: LocaleKeys.homeTextFieldEmailDesc.tr(),
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                  )),
                              const SizedBox(height: 30),
                              TextFormField(
                                  cursorColor: Colors.amber,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: t2,
                                  decoration: InputDecoration(
                                    hintText: LocaleKeys.homeTextFieldPasswordDesc.tr(),
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  )),
                              const SizedBox(height: 30),
                              MovieButton(
                                context: context,
                                buttonDescription: LocaleKeys.homeButtonEntry.tr(),
                                onPressed: () {
                                  signIn();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                              ),
                              const SizedBox(height: 30),
                              RichText(
                                  text: TextSpan(style: Theme.of(context).textTheme.subtitle1, children: [
                                TextSpan(
                                    text: LocaleKeys.homeTextSpanAccountExist.tr(),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) => const SignUp()));
                                      }),
                              ])),
                              const SizedBox(height: 30),
                              RichText(
                                  text: TextSpan(style: Theme.of(context).textTheme.subtitle1, children: [
                                TextSpan(
                                    text: LocaleKeys.homeTextSpanForgotPass.tr(),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) => ResetPassword()));
                                      }),
                              ])),
                            ],
                          ),
                        ),
                      );
                    });
              },
              buttonDescription: LocaleKeys.homeButtonEntry.tr(),
            ),
            const IconLanguage(),
          ],
        ),
      ),
    );
  }
}
