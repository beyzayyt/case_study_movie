import 'package:case_study/localization/constant.dart';
import 'package:case_study/ui/home_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class IconLanguage extends StatelessWidget {
  const IconLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.language),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                            ),
                            onPressed: () {
                              context.setLocale(AppConstant.ES_LOCALE);
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.language),
                                Text("es-ES"),
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                            ),
                            onPressed: () {
                              context.setLocale(AppConstant.EN_LOCALE);
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.language),
                                Text("EN-US"),
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                            ),
                            onPressed: () {
                              context.setLocale(AppConstant.TR_LOCALE);
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.language),
                                Text("TR"),
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                            ),
                            onPressed: () {
                              context.setLocale(AppConstant.DE_LOCALE);
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.language),
                                Text("DE"),
                              ],
                            )),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, MaterialPageRoute(builder: (context) => const MovieRecommenderHome()));
                        },
                        child: const Text(
                          "Ok",
                          style: TextStyle(color: Colors.amber),
                        ))
                  ],
                );
              });
        });
  }
}
