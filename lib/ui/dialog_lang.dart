import 'package:case_study/localization/constant.dart';
import 'package:case_study/ui/home_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconLanguage extends StatefulWidget {
  const IconLanguage({Key? key}) : super(key: key);

  @override
  State<IconLanguage> createState() => _IconLanguageState();
}

class _IconLanguageState extends State<IconLanguage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.language),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {

                              context.setLocale(AppConstant.ES_LOCALE);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.language),
                                Text("es-ES"),
                              ],
                            )),
                        ElevatedButton(
                            onPressed: () {
                              context.setLocale(AppConstant.EN_LOCALE);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.language),
                                Text("EN-US"),
                              ],
                            )),
                        ElevatedButton(
                            onPressed: () {
                              context.setLocale(AppConstant.TR_LOCALE);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.language),
                                Text("TR"),
                              ],
                            )),
                        ElevatedButton(
                            onPressed: () {
                              context.setLocale(AppConstant.DE_LOCALE);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.language),
                                Text("DE"),
                              ],
                            )),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieRecomenderHome()));
                        },
                        child: Text("Ok"))
                  ],
                );
              });
        });
  }
}
