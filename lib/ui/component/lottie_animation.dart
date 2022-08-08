import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends Column {
  LottieAnimation(
      {Key? key, required BuildContext context,
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
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ]);
}
