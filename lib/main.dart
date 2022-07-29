import 'package:case_study/ui/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'localization/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: AppConstant.SUPPORTED_LOCALE,
        path: AppConstant.LANG_PATH,
        fallbackLocale: Locale('tr', 'TR'),
        child: MovieRecomender(),
      ),
  );
}

class MovieRecomender extends StatelessWidget {
  const MovieRecomender({Key? key}) : super(key: key);

  // Widget _buildWithTheme(BuildContext context, ThemeState state) {
  //   return MaterialApp(
  //     localizationsDelegates: context.localizationDelegates,
  //     supportedLocales: context.supportedLocales,
  //     locale: context.locale,
  //     title: 'Material App',
  //     home: MovieRecomenderHome(),
  //     theme: state.themeData,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Material App',
      home: MovieRecomenderHome(),
      // theme: state.themeData,
    );
  }
}


//  return  BlocProvider(
// builder: (context) => ThemeBloc(),
// child: BlocBuilder<ThemeBloc, ThemeState>(
// builder: _buildWithTheme,
// ),
// );