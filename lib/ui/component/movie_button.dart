import 'package:flutter/material.dart';

class MovieButton extends ElevatedButton {
  MovieButton({
    EdgeInsets? padding,
    Key? key,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Expanded? expanded,
    Clip clipBehavior = Clip.none,
    String buttonDescription = '',
  }) : super(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
          primary: Colors.amber,
          fixedSize: const Size(200, 50),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(buttonDescription),
      ));
}