import 'package:case_study/logic/cubit/switch_cubit.dart';
import 'package:case_study/ui/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: const MovieRecommender(),
    ),
  );
}

class MovieRecommender extends StatelessWidget {
  const MovieRecommender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
      create: (context) => SwitchCubit(),
      child: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state.theme,
            home: const MovieRecommenderHome(),
          );
        },
      ),
    );
  }
}
