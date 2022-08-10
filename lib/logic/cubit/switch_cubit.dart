import 'package:bloc/bloc.dart';
import 'package:case_study/ui/presentation/theme/themeData.dart';
import 'package:flutter/material.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  // Initial mode set "isDarkThemeOn: false"
  SwitchCubit() : super(SwitchState(isDarkThemeOn: false));

  void toggleSwitch(bool value) => emit(state.copyWith(changeState: value));
}
