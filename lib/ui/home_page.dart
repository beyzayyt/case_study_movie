import 'package:case_study/localization/constant.dart';
import 'package:case_study/localization/local_keys.dart';
// import 'package:case_study/theme/app_theme.dart';
// import 'package:case_study/theme/theme_bloc.dart';
// import 'package:case_study/theme/theme_event.dart';
import 'package:case_study/ui/search_movie_page.dart';
import 'package:case_study/ui/sign_up_page.dart';
import 'package:case_study/ui/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'component/lottie_animation.dart';
import 'component/movie_button.dart';

class MovieRecomenderHome extends StatefulWidget {
  const MovieRecomenderHome({Key? key}) : super(key: key);

  @override
  State<MovieRecomenderHome> createState() => _MovieRecomenderHomeState();
}

class _MovieRecomenderHomeState extends State<MovieRecomenderHome> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var incomingTitleUsername = "";
  var incomingContentUsername = "";
  var incomingTitlePassword = "";
  var incomingContentPassword = "";

  void addingText() {
    //Created collection and put it in data.
    //Can update exist data.
    FirebaseFirestore.instance.collection("user_information").doc(t1.text) // t1'den gelen text
        .set({'title': t1.text, 'content': t2.text}).whenComplete(() => bringText());
    //Adding data
  }

  void bringText() {
    //Bring text
    FirebaseFirestore.instance.collection("user_information").doc(t1.text).get().then((incomingData) => {
          setState(() {
            incomingTitleUsername = incomingData.data()!['key1'];
            incomingContentPassword = incomingData.data()!['key2'];
          })
        });
  }

  signIn() {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: t1.text, password: t2.text).then((kullanici) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SearchMovie()));
    });
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[200],
          elevation: 0,
          title: Text(LocaleKeys.main_title.tr()),
          leading: GestureDetector(
            onTap: () { context.setLocale(AppConstant.ES_LOCALE); },
            child: const Icon(
              Icons.change_circle,  // add custom icons also
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // BlocProvider.of<ThemeBloc>(context)
                //     .dispatch(ThemeChanged(theme: AppTheme.Dark)
                //);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LottieAnimation(
                path: 'assets/lottie/movie.json',
                descriptionTitle: 'Kullanıcılar film arayıp, \nfavori listelerini oluşturabilecekler',
                description: 'Lütfen devam etmek için giriş yapınız',
              ),
              MovieButton(
                onPressed: () {
                  showModalBottomSheet<dynamic>(
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
                                    keyboardType: TextInputType.text,
                                    controller: t1,
                                    decoration: const InputDecoration(
                                      hintText: "Mail adresinizi giriniz",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    )),
                                SizedBox(height: 30),
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: t2,
                                    decoration: const InputDecoration(
                                      hintText: "Şifre giriniz",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    )),
                                SizedBox(height: 30),
                                MovieButton(
                                  buttonDescription: 'Giriş yap',
                                  onPressed: () {
                                    signIn();
                                  },
                                ),
                                SizedBox(height: 30),
                                RichText(
                                    text: TextSpan(style: TextStyle(color: Colors.grey, fontSize: 20.0), children: [
                                      TextSpan(
                                          text: 'Hesabınız yok mu',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                                            }),
                                    ])),
                                SizedBox(height: 30),
                                RichText(
                                    text: TextSpan(style: TextStyle(color: Colors.grey, fontSize: 20.0), children: [
                                      TextSpan(
                                          text: 'Şifremi Unuttum',
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
                buttonDescription: 'Giriş Yap',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
