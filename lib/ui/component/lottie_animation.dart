import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends Column {
  LottieAnimation(
      {Key? key,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
      MainAxisSize mainAxisSize = MainAxisSize.max,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      TextDirection? textDirection,
      VerticalDirection verticalDirection = VerticalDirection.down,
      TextBaseline? textBaseline,
      Duration? duration,
      String path = '',
      String descriptionTitle = '',
      String description = '',
      LottieComposition? composition})
      : super(
            key: key,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            children: <Widget>[
              composition != null ? Lottie(composition: composition) : Lottie.asset(path),
              Text(
                descriptionTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
              ),
            ]);
}
